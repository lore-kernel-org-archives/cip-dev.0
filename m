From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Thu, 19 Jan 2017 15:57:44 +0100
Subject: [cip-dev] [PATCH] Use local copy of kernel-ci if present
Message-ID: <20170119145744.6754-1-daniel.wagner@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

In order to develop or debug the setup we should allow to a developer
to use local copy of the sources.

This is done by cloning all the remote repos to the project main
folder. This folder is shared with the VM. The intergration-scripts
are testing if those repos are in the shared folder than git clone
uses this as source.

To simplify the developer setup a simple setup-dev-env.sh script
is added. Note the current path should be the top folder of the
project.

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
Hi,

This helped me to quite a bit to get things tested in a more simpler
way. What do you think?

cheers,
daniel

 integration-scripts/install_backend.sh      |  8 +++++++-
 integration-scripts/install_build_script.sh |  9 ++++++++-
 integration-scripts/install_frontend.sh     |  8 +++++++-
 scripts/setup-dev-env.sh                    | 11 +++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 scripts/setup-dev-env.sh

diff --git a/integration-scripts/install_backend.sh b/integration-scripts/install_backend.sh
index 72a974033a3c..157e7184e349 100755
--- a/integration-scripts/install_backend.sh
+++ b/integration-scripts/install_backend.sh
@@ -4,7 +4,13 @@
 # Install kernelci backend
 
 cd $HOME && mkdir git-repos && cd git-repos
-git clone https://github.com/kernelci/kernelci-backend-config.git kernelci-backend
+
+GIT_SRC="https://github.com/kernelci/kernelci-backend-config.git"
+if [ -d /vagrant/kernelci-backend-config ]; then
+    GIT_SRC=/vagrant/kernelci-backend-config
+fi
+git clone $GIT_SRC kernelci-backend
+
 cp /vagrant/config/secrets-backend.yml kernelci-backend/secrets.yml
 
 # Fixme: Don't let ansible try to create the file in the first place.
diff --git a/integration-scripts/install_build_script.sh b/integration-scripts/install_build_script.sh
index 322619317af6..879aaed01792 100755
--- a/integration-scripts/install_build_script.sh
+++ b/integration-scripts/install_build_script.sh
@@ -3,7 +3,14 @@
 # Copyright (C) 2016, Siemens AG, Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
 # SPDX-License-Identifier:	Apache-2.0
 
-cd $HOME && git clone https://github.com/kernelci/kernelci-build.git
+cd $HOME
+
+GIT_SRC="https://github.com/kernelci/kernelci-build.git"
+if [ -d /vagrant/kernelci-build ]; then
+    GIT_SRC=/vagrant/kernelci-build
+fi
+git clone $GIT_SRC
+
 cd kernelci-build
 
 MASTER_KEY=`cat $HOME/backend-admin-token.txt`
diff --git a/integration-scripts/install_frontend.sh b/integration-scripts/install_frontend.sh
index 48ab91ab83ce..251ef89d28f3 100755
--- a/integration-scripts/install_frontend.sh
+++ b/integration-scripts/install_frontend.sh
@@ -4,7 +4,13 @@
 # Install kernelci frontend
 
 cd $HOME/git-repos
-git clone https://github.com/kernelci/kernelci-frontend-config.git kernelci-frontend
+
+GIT_SRC="https://github.com/kernelci/kernelci-frontend-config.git"
+if [ -d /vagrant/kernelci-frontend-config ]; then
+    GIT_SRC=/vagrant/kernelci-frontend-config
+fi
+git clone $GIT_SRC kernelci-frontend
+
 sed -i kernelci-frontend/roles/install-app/tasks/main.yml \
     -e 's/kernelci\/kernelci-frontend.git/siemens\/kernelci-frontend.git/'
 
diff --git a/scripts/setup-dev-env.sh b/scripts/setup-dev-env.sh
new file mode 100644
index 000000000000..59c13b233065
--- /dev/null
+++ b/scripts/setup-dev-env.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+if [ ! -f "Vagrantfile" ]; then
+    echo "script is supposed to be run from the top folder where"
+    echo "the Vagrantfile is."
+    exit 1
+fi
+
+git clone https://github.com/kernelci/kernelci-backend-config.git
+git clone https://github.com/kernelci/kernelci-build.git
+git clone https://github.com/kernelci/kernelci-frontend-config.git
-- 
2.9.3
