From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Wed, 28 Aug 2019 11:26:19 +0900
Subject: [cip-dev] [PATCH 3/3] Add spectre-meltdown-checker test
In-Reply-To: <20190828022619.3690-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20190828022619.3690-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <20190828022619.3690-3-nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 lava_templates/r8a7743-iwg20d-q7_smc.yaml     | 69 +++++++++++++++++++
 lava_templates/r8a7745-iwg22d-sodimm_smc.yaml | 69 +++++++++++++++++++
 lava_templates/r8a774c0-ek874_smc.yaml        | 69 +++++++++++++++++++
 submit_tests.sh                               |  1 +
 4 files changed, 208 insertions(+)
 create mode 100644 lava_templates/r8a7743-iwg20d-q7_smc.yaml
 create mode 100644 lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
 create mode 100644 lava_templates/r8a774c0-ek874_smc.yaml

diff --git a/lava_templates/r8a7743-iwg20d-q7_smc.yaml b/lava_templates/r8a7743-iwg20d-q7_smc.yaml
new file mode 100644
index 0000000..0e10584
--- /dev/null
+++ b/lava_templates/r8a7743-iwg20d-q7_smc.yaml
@@ -0,0 +1,69 @@
+# Copyright (C) 2019, Renesas Electronics Europe GmbH, Chris Paterson <chris.paterson2@renesas.com>
+# SPDX-License-Identifier:	AGPL-3.0
+# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
+# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
+# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+device_type: r8a7743-iwg20d-q7
+job_name: JOB_NAME
+
+timeouts:
+  job:
+    minutes: 15
+  action:
+    minutes: 10
+  connection:
+    minutes: 5
+priority: medium
+visibility: public
+
+notify:
+  criteria:
+    status: finished
+  verbosity: verbose
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results at lists.cip-project.org
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: uimage
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.tar.gz
+      compression: gz
+    dtb:
+      url: DTB_URL
+
+# BOOT_BLOCK
+- boot:
+    auto_login:
+      login_prompt: 'ciphost login:'
+      username: root
+    prompts:
+      - 'cip-project#'
+    method: u-boot
+    commands: nfs
+    timeout:
+      minutes: 5
+
+# Spectre meltdown checker
+# TEST_BLOCK
+- test:
+   timeout:
+     minutes: 10
+   definitions:
+   - repository: https://github.com/Linaro/test-definitions.git
+     from: git
+     path: automated/linux/spectre-meltdown-checker-test/spectre-meltdown-checker-test.yaml
+     name: spectre-meltdown-checker-test
+     timeout:
+       minutes: 10
+
diff --git a/lava_templates/r8a7745-iwg22d-sodimm_smc.yaml b/lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
new file mode 100644
index 0000000..180d94a
--- /dev/null
+++ b/lava_templates/r8a7745-iwg22d-sodimm_smc.yaml
@@ -0,0 +1,69 @@
+# Copyright (C) 2019, Renesas Electronics Europe GmbH, Chris Paterson <chris.paterson2@renesas.com>
+# SPDX-License-Identifier:	AGPL-3.0
+# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
+# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
+# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+device_type: r8a7745-iwg22d-sodimm
+job_name: JOB_NAME
+
+timeouts:
+  job:
+    minutes: 15
+  action:
+    minutes: 10
+  connection:
+    minutes: 5
+priority: medium
+visibility: public
+
+notify:
+  criteria:
+    status: finished
+  verbosity: verbose
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results at lists.cip-project.org
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: uimage
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/core-image-minimal-iwg22m-20181126155628.rootfs.tar.gz
+      compression: gz
+    dtb:
+      url: DTB_URL
+
+# BOOT_BLOCK
+- boot:
+    auto_login:
+      login_prompt: 'iwg22m login: '
+      username: root
+    prompts:
+      - 'root at iwg22m'
+    method: u-boot
+    commands: nfs
+    timeout:
+      minutes: 5
+
+# Spectre meltdown checker
+# TEST_BLOCK
+- test:
+   timeout:
+     minutes: 10
+   definitions:
+   - repository: https://github.com/Linaro/test-definitions.git
+     from: git
+     path: automated/linux/spectre-meltdown-checker-test/spectre-meltdown-checker-test.yaml
+     name: spectre-meltdown-checker-test
+     timeout:
+       minutes: 10
+
diff --git a/lava_templates/r8a774c0-ek874_smc.yaml b/lava_templates/r8a774c0-ek874_smc.yaml
new file mode 100644
index 0000000..e244a0e
--- /dev/null
+++ b/lava_templates/r8a774c0-ek874_smc.yaml
@@ -0,0 +1,69 @@
+# Copyright (C) 2019, Renesas Electronics Europe GmbH, Chris Paterson <chris.paterson2@renesas.com>
+# SPDX-License-Identifier:	AGPL-3.0
+# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
+# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
+# You should have received a copy of the GNU Affero General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+device_type: r8a774c0-ek874
+job_name: JOB_NAME
+
+timeouts:
+  job:
+    minutes: 15
+  action:
+    minutes: 10
+  connection:
+    minutes: 5
+priority: medium
+visibility: public
+
+notify:
+  criteria:
+    status: finished
+  verbosity: verbose
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results at lists.cip-project.org
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: image
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/core-image-bsp-ek874.tar.gz
+      compression: gz
+    dtb:
+      url: DTB_URL
+
+# BOOT_BLOCK
+- boot:
+    auto_login:
+      login_prompt: 'ek874 login:'
+      username: root
+    prompts:
+      - 'root at ek874'
+    method: u-boot
+    commands: nfs
+    timeout:
+      minutes: 5
+
+# Spectre meltdown checker
+# TEST_BLOCK
+- test:
+   timeout:
+     minutes: 10
+   definitions:
+   - repository: https://github.com/Linaro/test-definitions.git
+     from: git
+     path: automated/linux/spectre-meltdown-checker-test/spectre-meltdown-checker-test.yaml
+     name: spectre-meltdown-checker-test
+     timeout:
+       minutes: 10
+
diff --git a/submit_tests.sh b/submit_tests.sh
index 5f83182..b1a275e 100755
--- a/submit_tests.sh
+++ b/submit_tests.sh
@@ -150,6 +150,7 @@ find_jobs () {
 
 			print_kernel_info
 			create_job healthcheck
+			create_job smc
 		done < $jobfile
 	done
 }
-- 
2.20.1
