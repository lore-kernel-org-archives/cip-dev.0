From: gitlab@mg.gitlab.com (Agustin Benito Bethencourt)
Date: Tue, 20 Feb 2018 09:21:35 +0000
Subject: [cip-dev] [Git][cip-project/cip-testing/kernelci-build][master] 2
 commits: Add licence headers #110
Message-ID: <5a8be89fe34b0_18d8e3f9807e082a4849919a@sidekiq-asap-05.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin Benito Bethencourt pushed to branch master at cip-project / cip-testing / kernelci-build


Commits:
ab0ca46a by Robert Marshall at 2017-06-30T15:50:44+01:00
Add licence headers #110

- - - - -
e2b922a7 by Robert Marshall at 2017-10-12T11:28:12+00:00
Add new file LICENSE.spdx
- - - - -


3 changed files:

- + LICENSE.spdx
- build-complete.sh
- build.py


Changes:

=====================================
LICENSE.spdx
=====================================
--- /dev/null
+++ b/LICENSE.spdx
@@ -0,0 +1,12 @@
+DataLicense: CC0-1.0
+PackageName: B at D
+DataFormat: SPDXRef-1
+PackageSupplier: Organization: Linux Foundation
+PackageHomePage: https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting
+PackageLicenseDeclared: AGPL-3.0
+PackageCopyrightText: 2017, Codethink Ltd
+PackageSummary: <text>kernelci build scripts
+                </text>
+Created: 2017-10-12
+PackageDownloadLocation: https://gitlab.com/cip-project/cip-testing/kernelci-build
+Creator: Person: Robert Marshall


=====================================
build-complete.sh
=====================================
--- a/build-complete.sh
+++ b/build-complete.sh
@@ -1,4 +1,19 @@
 #!/bin/bash
+# Copyright (C) 2017, Linaro Ltd.
+# Copyright (C) 2017 Linux Foundation
+# Copyright (C) 2017, Codethink, Ltd.
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU Affero General Public License as
+# published by the Free Software Foundation, either version 3 of the
+# License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU Affero General Public License for more details.
+#
+# You should have received a copy of the GNU Affero General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 rm -rf *
 


=====================================
build.py
=====================================
--- a/build.py
+++ b/build.py
@@ -1,4 +1,18 @@
 #!/usr/bin/env python
+# Copyright (C) 2017, Codethink, Ltd., Robert Marshall
+# SPDX-License-Identifier:	AGPL-3.0
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU Affero General Public License as
+# published by the Free Software Foundation, either version 3 of the
+# License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU Affero General Public License for more details.
+#
+# You should have received a copy of the GNU Affero General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 # NOTES:
 # - override ARCH and CROSS_COMPILE using environment variables



View it on GitLab: https://gitlab.com/cip-project/cip-testing/kernelci-build/compare/13286cea39d3a400a386ae2d3180b3e763d0c24a...e2b922a78afb2cfe28fd44b2827f407e3623f4cc

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/kernelci-build/compare/13286cea39d3a400a386ae2d3180b3e763d0c24a...e2b922a78afb2cfe28fd44b2827f407e3623f4cc
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180220/54b2bddc/attachment-0001.html>
