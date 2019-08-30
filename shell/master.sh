#!/usr/local/env bash
npm install && \
npm run build && \
rm -rf .git && \
git clone https://github.com/LucienShui/PasteMeFrontend.git -b build tmpdir && \
cp -r tmpdir/.git pasteme && \
cp nginx.conf LICENSE DEPLOY.md pasteme && \
cd pasteme && \
rm report.html && \
mv DEPLOY.md README.md && \
git config user.name "Lucien Shui" && \
git config user.email "lucien@lucien.ink" && \
git add --all && \
git commit -m "build from travis-ci `TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S'`" && \
git push https://${GH_TOKEN}@github.com/LucienShui/PasteMeFrontend.git build && \
curl -X POST ${WEBHOOK}${WEBHOOK_PATH} && \
echo 'Start updating PasteMe dev' && \
git clone https://github.com/LucienShui/PasteMe.git -b dev PasteMeDev --recursive && \
cd PasteMeDev && \
git submodule foreach git pull origin master && \
git config user.name "Lucien Shui" && \
git config user.email "lucien@lucien.ink" && \
git add --all && \
git commit -m "push from travis-ci `TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S'`" && \
git push https://${GH_TOKEN}@github.com/LucienShui/PasteMe.git dev
