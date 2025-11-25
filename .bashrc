## first find a list of all dups ## 
yum --showduplicates list nginx
## now update to particular version ##
sudo yum update-to nginx-version
sudo yum update-to nginx-1.12.2-1.el7

sudo apt install build-essential libssl-dev libgdbm-dev libdb-dev libexpat-dev libncurses5-dev libbz2-dev zlib1g-dev gawk bison
sudo yum groupinstall "Development Tools"

wget https://ftp.gnu.org/gnu/glibc/glibc-2.39.tar.xz
wget https://ftp.gnu.org/gnu/glibc/glibc-2.38.tar.bz2

cd glibc-2.39
mkdir build
cd build
../configure --prefix=/usr/local/glibc-2.39
make -j4
sudo make install

export LD_LIBRARY_PATH=/usr/local/glibc-2.39/lib:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/usr/local/glibc-2.39/lib:$LD_LIBRARY_PATH

tar -xvf glibc-2.39.tar.xz
tar -xvf glibc-2.38.tar.xz
export LD_LIBRARY_PATH=/usr/local/glibc-2.38/lib:$LD_LIBRARY_PATH
/usr/local/glibc-2.39/lib/ld-2.30.so --version
/usr/local/glibc-2.38/lib/ld-2.31.so --version

$ Make sure git-lfs is installed (https://git-lfs.com)
git lfs install

git remote add origin git@hf.co:Seriki/ProjectpilotAI

# Make sure SSH key is set in your user settings (https://huggingface.co/settings/keys)
git push -u origin main

curl -SL https://github.com/docker/compose/releases/download/v2.37.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

 Start-BitsTransfer -Source "https://github.com/docker/compose/releases/download/v2.37.3/docker-compose-windows-x86_64.exe" -Destination $Env:ProgramFiles\Docker\docker-compose.exe

 composer create-project hunwalk/yii2-basic-firestarter <project_pilot_AI> --prefer-dist

 php yii migrate-user
 php yii migrate-rbac
 php yii migrate

 cp .env.example .env

npm install --save-dev @commitlint/config-conventional @commitlint/cli
echo "export default {extends: ['@commitlint/config-conventional']};" > commitlint.config.js

npm install commitizen -g

npm
commitizen init cz-conventional-changelog --save-dev --save-exact

# yarn
commitizen init cz-conventional-changelog --yarn --dev --exact

# pnpm
commitizen init cz-conventional-changelog --pnpm --save-dev --save-exact

npx commitizen init cz-conventional-changelog --save-dev --save-exact
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
