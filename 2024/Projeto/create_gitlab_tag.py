import requests
import re
import os
import subprocess
from datetime import date

# Defina suas variáveis
GITLAB_API_URL = 'https://gitlab.com/api/v4'
PROJECT_ID = '00000000'  # Substitua pelo ID do seu projeto
ACCESS_TOKEN = 'abcd-123456789012345'  # Substitua pelo seu token de acesso pessoal
VERSION_INCREMENT_TYPE = os.getenv('VERSION_INCREMENT_TYPE', 'patch')  # Obter do ambiente, default para 'patch'
branch_name = "develop"  # Nome da branch que você deseja usar

def get_latest_tag():
    headers = {
        'PRIVATE-TOKEN': ACCESS_TOKEN
    }
    
    url = f'{GITLAB_API_URL}/projects/{PROJECT_ID}/repository/tags'
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        tags = response.json()
        if tags:
            return tags[0]['name']  # Retorna a tag mais recente
        else:
            return None  # Nenhuma tag existente
    else:
        print(f'Erro ao obter tags: {response.status_code}')
        print(response.json())
        return None

def increment_version(version, increment_type):
    major, minor, patch = map(int, re.findall(r'\d+', version))
    
    if increment_type == 'major':
        major += 1
        minor = 0
        patch = 0
    elif increment_type == 'minor':
        minor += 1
        patch = 0
    elif increment_type == 'patch':
        patch += 1
    else:
        raise ValueError('Tipo de incremento inválido. Escolha "major", "minor" ou "patch".')
    
    return f'v{major}.{minor}.{patch}'   
    
def run_git_command(command):
    try:
        result = subprocess.run(command, shell=True, check=True, text=True, capture_output=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Erro ao executar comando: {e.cmd}")
        print(f"Código de saída: {e.returncode}")
        print(f"Saída do erro: {e.stderr}")
        raise

def check_git_repo():
    try:
        run_git_command("git rev-parse --is-inside-work-tree")
    except subprocess.CalledProcessError:
        raise EnvironmentError("O diretório atual não é um repositório Git.")

def check_local_branch(branch_name):
    local_branches = run_git_command("git branch --list")
    return branch_name in local_branches

def check_remote_branch(branch_name):
    remote_branches = run_git_command("git ls-remote --heads origin")
    return f"refs/heads/{branch_name}" in remote_branches

def configure_git_credentials():
    user_email = os.getenv('GIT_USER_EMAIL', 'seuemail@provedor.com.br')
    user_name = os.getenv('GIT_USER_NAME', 'UserName')
    run_git_command(f'git config --global user.email "{user_email}"')
    run_git_command(f'git config --global user.name "{user_name}"')
    token = ACCESS_TOKEN
    if token:
        run_git_command(f"git remote set-url origin https://oauth2:{token}@gitlab.com/treinamento5402750/econ-2024.git")
        
def get_commits_since_tag(tag):
    """Obtém a lista de commits desde a última tag."""
    result = subprocess.run(['git', 'log', f'{tag}..HEAD', '--pretty=format:%s'], stdout=subprocess.PIPE)
    return result.stdout.decode('utf-8').splitlines()        
        
def categorize_commits(commits):
    """Organiza commits em categorias de acordo com o formato 'Keep a Changelog'."""
    categories = {
        'Added': [],
        'Changed': [],
        'Deprecated': [],
        'Removed': [],
        'Fixed': [],
        'Security': []
    }

    # Categoriza cada commit
    for commit in commits:
        if 'add' in commit.lower():
            categories['Added'].append(commit)
        elif 'change' in commit.lower() or 'update' in commit.lower():
            categories['Changed'].append(commit)
        elif 'fix' in commit.lower():
            categories['Fixed'].append(commit)
        elif 'deprecated' in commit.lower():
            categories['Deprecated'].append(commit)
        elif 'remove' in commit.lower():
            categories['Removed'].append(commit)
        elif 'security' in commit.lower():
            categories['Security'].append(commit)

    return categories        
        
def update_changelog(changelog_file, categorized_commits, new_version):
    """Atualiza o changelog com novas entradas, seguindo o formato 'Keep a Changelog'."""
    today = date.today().strftime("%Y-%m-%d")
    
    with open(changelog_file, 'r') as file:
        content = file.readlines()

    with open(changelog_file, 'w') as file:
        # Adiciona a nova versão ao topo do changelog
        file.write(f"## [{new_version}] - {today}\n")

        for category, messages in categorized_commits.items():
            if messages:
                file.write(f"\n### {category}\n")
                for message in messages:
                    file.write(f"- {message}\n")
        file.write("\n")
        file.writelines(content)

if __name__ == "__main__":
    latest_tag = get_latest_tag()
    # Defina o caminho para o arquivo .pas e a nova versão desejada
    file_path = 'src/constantes/ECon24.constantes.Version.pas'
    if latest_tag:
        new_tag = increment_version(latest_tag, VERSION_INCREMENT_TYPE)
        commits = get_commits_since_tag(latest_tag)        
    else:
        # Se não houver nenhuma tag, comece com v0.1.0
        new_tag = 'v0.1.0'
        commits = get_commits_since_tag('')
    
    # Configura as credenciais do Git, se necessário
    configure_git_credentials()

    # Verifica se estamos em um repositório Git
    check_git_repo()

    # Verifica se a branch 'develop' existe localmente ou remotamente
    if not check_local_branch(branch_name):
        print(f"A branch '{branch_name}' não existe localmente.")
        # Tente buscar a branch do repositório remoto
        if not check_remote_branch(branch_name):
            print(f"A branch '{branch_name}' não existe no repositório remoto. Criando localmente...")
            run_git_command(f"git checkout -b {branch_name}")
        else:
            run_git_command(f"git fetch origin {branch_name}:{branch_name}")
            run_git_command(f"git checkout {branch_name}")
    else:
        run_git_command(f"git checkout {branch_name}")

    # Atualiza o número da versão no arquivo .pas
    with open(file_path, 'r') as file:
        content = file.read()

    updated_content = re.sub(r"(VERSION = ')[^']*(')", rf"\1{new_tag}\2", content)

    with open(file_path, 'w') as file:
        file.write(updated_content)

    run_git_command(f"git add {file_path}")
    
    # Atualiza o ChangeLog    
    categorized_commits = categorize_commits(commits)
    update_changelog('CHANGELOG.md', categorized_commits, new_tag)

    status_output = run_git_command("git status --porcelain")
    if not status_output:
        print("Nenhuma alteração para commitar.")
    else:
        run_git_command(f'git commit -m "Atualiza versão para {new_tag}"')

    run_git_command(f"git push origin {branch_name}")
    run_git_command(f"git tag {new_tag}")
    run_git_command(f"git push origin {new_tag}")

    print(f"Versão atualizada para {new_tag} e tag {new_tag} criada e enviada com sucesso.")