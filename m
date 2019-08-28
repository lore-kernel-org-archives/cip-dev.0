From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Wed, 28 Aug 2019 11:26:18 +0900
Subject: [cip-dev] [PATCH 2/3] Change to specify test name as argument to
	create_job
In-Reply-To: <20190828022619.3690-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20190828022619.3690-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <20190828022619.3690-2-nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 ...20d-q7.yaml => r8a7743-iwg20d-q7_healthcheck.yaml} |  0
 ...mm.yaml => r8a7745-iwg22d-sodimm_healthcheck.yaml} |  0
 ...4c0-ek874.yaml => r8a774c0-ek874_healthcheck.yaml} |  0
 submit_tests.sh                                       | 11 ++++++-----
 4 files changed, 6 insertions(+), 5 deletions(-)
 rename lava_templates/{r8a7743-iwg20d-q7.yaml => r8a7743-iwg20d-q7_healthcheck.yaml} (100%)
 rename lava_templates/{r8a7745-iwg22d-sodimm.yaml => r8a7745-iwg22d-sodimm_healthcheck.yaml} (100%)
 rename lava_templates/{r8a774c0-ek874.yaml => r8a774c0-ek874_healthcheck.yaml} (100%)

diff --git a/lava_templates/r8a7743-iwg20d-q7.yaml b/lava_templates/r8a7743-iwg20d-q7_healthcheck.yaml
similarity index 100%
rename from lava_templates/r8a7743-iwg20d-q7.yaml
rename to lava_templates/r8a7743-iwg20d-q7_healthcheck.yaml
diff --git a/lava_templates/r8a7745-iwg22d-sodimm.yaml b/lava_templates/r8a7745-iwg22d-sodimm_healthcheck.yaml
similarity index 100%
rename from lava_templates/r8a7745-iwg22d-sodimm.yaml
rename to lava_templates/r8a7745-iwg22d-sodimm_healthcheck.yaml
diff --git a/lava_templates/r8a774c0-ek874.yaml b/lava_templates/r8a774c0-ek874_healthcheck.yaml
similarity index 100%
rename from lava_templates/r8a774c0-ek874.yaml
rename to lava_templates/r8a774c0-ek874_healthcheck.yaml
diff --git a/submit_tests.sh b/submit_tests.sh
index 7dff7a2..5f83182 100755
--- a/submit_tests.sh
+++ b/submit_tests.sh
@@ -47,11 +47,12 @@ clean_up () {
 }
 
 get_template () {
-	TEMPLATE="$TEMPLATE_DIR/$DEVICE.yaml"
+	TEMPLATE="${TEMPLATE_DIR}/${DEVICE}_${1}.yaml"
 }
 
 create_job () {
-	get_template
+	local testname="$1"
+	get_template $testname
 
 	local dtb_url="$AWS_URL_DOWN/$DTB"
 	local kernel_url="$AWS_URL_DOWN/$KERNEL"
@@ -59,9 +60,9 @@ create_job () {
 
 	INDEX="0"
 	if $USE_DTB; then
-		local job_name="${VERSION}_${ARCH}_${CONFIG}_${DTB_NAME}"
+		local job_name="${VERSION}_${ARCH}_${CONFIG}_${DTB_NAME}_${testname}"
 	else
-		local job_name="${VERSION}_${ARCH}_${CONFIG}"
+		local job_name="${VERSION}_${ARCH}_${CONFIG}_${testname}"
 	fi
 
 	local job_definition="$TMP_DIR/${INDEX}_${job_name}.yaml"
@@ -148,7 +149,7 @@ find_jobs () {
 			fi
 
 			print_kernel_info
-			create_job
+			create_job healthcheck
 		done < $jobfile
 	done
 }
-- 
2.20.1
