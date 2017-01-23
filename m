From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 23 Jan 2017 10:50:28 +0100
Subject: [cip-dev] [PATCH] Use local copy of kernel-ci if present
In-Reply-To: <2a5ecb13-29c2-d80d-ffb4-b3459eb0e03d@siemens.com>
References: <20170119145744.6754-1-daniel.wagner@siemens.com>
	<69aca7a7-5d83-190e-733f-85d0b57891b8@linux-kernel.net>
	<2a5ecb13-29c2-d80d-ffb4-b3459eb0e03d@siemens.com>
Message-ID: <4566da15-839f-e88f-f812-095d7ee770ba@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Don,

Over the weekend I had an idea to improve it even more:


GIT_SRC="https://github.com/kernelci/kernelci-backend-config.git"
if [ -d /vagrant/kernelci-backend-config ]; then
    GIT_SRC=/vagrant/kernelci-backend-config
fi
git clone $GIT_SRC kernelci-backend


If there is a repo available on /vagrant we clone from it. I 
think it would be even better just to copy the working
directory instead of cloning. That would allow to hack on the
files without committing all the time.

So this would change to:

if [ -d /vagrant/kernelci-backend-config ]; then
    cp -r /vagrant/kernelci-backend-config kernelci-backend
else
    git clone https://github.com/kernelci/kernelci-backend-config.git kernelci-backend
fi

What do you think about this?

And another idea I had: we should create a mirror of kernelci sources
clone from the mirror. I am pretty sure soon we have some patches
which need to be around to get our setup running which aren't 
available in the upstream repository. For example I had to do this here:


--- a/roles/install-deps/tasks/install-mongodb.yml
+++ b/roles/install-deps/tasks/install-mongodb.yml
@@ -2,7 +2,7 @@
 
 - name: Add MongoDB apt key (Ubuntu)
   apt_key:  id=7F0CEB10
-            keyserver=hkp://keyserver.ubuntu.com
+            keyserver=hkp://keyserver.ubuntu.com:80
   when: ansible_lsb.id == "Ubuntu"
   tags:
     - install
@@ -11,7 +11,7 @@
 
 - name: Add MongoDB apt key (Debian)
   apt_key:  id=EA312927
-            keyserver=hkp://keyserver.ubuntu.com
+            keyserver=hkp://keyserver.ubuntu.com:80
   when: ansible_lsb.id == "Debian"
   tags:
     - install

Thanks,
Daniel
