From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Wed, 28 Aug 2019 11:26:17 +0900
Subject: [cip-dev] [PATCH 1/3] Change templagte directory name
Message-ID: <20190828022619.3690-1-nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../r8a7743-iwg20d-q7.yaml                                    | 0
 .../r8a7745-iwg22d-sodimm.yaml                                | 0
 {healthcheck_templates => lava_templates}/r8a774c0-ek874.yaml | 0
 submit_tests.sh                                               | 2 +-
 test.Dockerfile                                               | 4 ++--
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename {healthcheck_templates => lava_templates}/r8a7743-iwg20d-q7.yaml (100%)
 rename {healthcheck_templates => lava_templates}/r8a7745-iwg22d-sodimm.yaml (100%)
 rename {healthcheck_templates => lava_templates}/r8a774c0-ek874.yaml (100%)

diff --git a/healthcheck_templates/r8a7743-iwg20d-q7.yaml b/lava_templates/r8a7743-iwg20d-q7.yaml
similarity index 100%
rename from healthcheck_templates/r8a7743-iwg20d-q7.yaml
rename to lava_templates/r8a7743-iwg20d-q7.yaml
diff --git a/healthcheck_templates/r8a7745-iwg22d-sodimm.yaml b/lava_templates/r8a7745-iwg22d-sodimm.yaml
similarity index 100%
rename from healthcheck_templates/r8a7745-iwg22d-sodimm.yaml
rename to lava_templates/r8a7745-iwg22d-sodimm.yaml
diff --git a/healthcheck_templates/r8a774c0-ek874.yaml b/lava_templates/r8a774c0-ek874.yaml
similarity index 100%
rename from healthcheck_templates/r8a774c0-ek874.yaml
rename to lava_templates/r8a774c0-ek874.yaml
diff --git a/submit_tests.sh b/submit_tests.sh
index 2911af1..7dff7a2 100755
--- a/submit_tests.sh
+++ b/submit_tests.sh
@@ -29,7 +29,7 @@ set -e
 ################################################################################
 WORK_DIR=`pwd`
 OUTPUT_DIR="$WORK_DIR/output"
-TEMPLATE_DIR="/opt/healthcheck_templates"
+TEMPLATE_DIR="/opt/lava_templates"
 ################################################################################
 AWS_URL_UP="s3://download.cip-project.org/ciptesting/ci"
 AWS_URL_DOWN="https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/ci"
diff --git a/test.Dockerfile b/test.Dockerfile
index 04e2ad9..d15f7a3 100644
--- a/test.Dockerfile
+++ b/test.Dockerfile
@@ -11,8 +11,8 @@ RUN apt-get update \
 # Install AWS CLI
 RUN pip3 install awscli
 
-# Copy healthcheck templates
-COPY healthcheck_templates /opt/healthcheck_templates
+# Copy lava templates
+COPY lava_templates /opt/lava_templates
 
 # Copy test script
 COPY submit_tests.sh /opt/
-- 
2.20.1
