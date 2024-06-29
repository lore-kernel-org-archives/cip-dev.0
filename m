Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C978C27C4F
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 06:28:08 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.1303.1719642478713059285
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 23:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=ulJYsP0C;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202406290627563bda0065b99395ea1c-atyh8r@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202406290627563bda0065b99395ea1c
        for <cip-dev@lists.cip-project.org>;
        Sat, 29 Jun 2024 08:27:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vHpYGcAbXkoi9AplndVL7GAL58Af3GIW8kz8NlatQEA=;
 b=ulJYsP0CnDSfLjbO4rL2V/D8rWknQefjYxMpVbjbG2EGGM7NzE3THt0fM0y+u+A+0UqPDI
 jEHahjK5EoObUq5XfMLQijivMnPdzw5EzluDvFFUIg/dbq90jw/af9gqLOR+c0WTG5NDT/dq
 3CZcPz4p0S0ozOacIGc/nhYd512IY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH 3/4] ci: Show live output of LAVA jobs
Date: Sat, 29 Jun 2024 08:27:53 +0200
Message-ID: <052b3192934f0582f1a151613f1cb56264a50327.1719642474.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719642474.git.jan.kiszka@siemens.com>
References: <cover.1719642474.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jun 2024 06:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16347

From: Jan Kiszka <jan.kiszka@siemens.com>

This both simplifies the code massively and provides direct access to
the test progress in gitlab.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 164 ++++-------------------------------------
 1 file changed, 13 insertions(+), 151 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 48c5d3c1..6bf844bf 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -154,32 +154,22 @@ submit_job() {
 			return 1
 		else
 			echo "Job submitted successfully as #${ret}."
+			echo "URL: ${LAVA_JOBS_URL}/${ret}"
 
 			local lavacli_output=${job_dir}/lavacli_output
 			# shellcheck disable=2086
 			lavacli $LAVACLI_ARGS jobs show "${ret}" \
 				> "$lavacli_output"
 
-			STATUS=$(grep "state" "$lavacli_output" \
-				| cut -d ":" -f 2 \
-				| awk '{$1=$1};1')
-
-			HEALTH=$(grep "Health" "$lavacli_output" \
-				| cut -d ":" -f 2 \
-				| awk '{$1=$1};1')
-
 			DEVICE=$(grep "device      :" "$lavacli_output" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
 
-			TESTING=$(grep "description" "$lavacli_output" \
-				| rev | cut -d "_" -f 1 | rev)
-
 			submit_squad_watch_job "${ret}" "${DEVICE}"
 
-			if ! check_status "$ret"; then
-				ERROR=true
-			fi
+			lavacli $LAVACLI_ARGS jobs logs "${ret}"
+			lavacli $LAVACLI_ARGS results "${ret}"
+
 			get_junit_test_results "$ret"
 		fi
 	else
@@ -227,151 +217,23 @@ validate_jobs () {
 	return $ret
 }
 
-check_if_finished () {
-	if [ "${STATUS}" != "Finished" ]; then
-		return 1
-	else
-		return 0
-	fi
-}
-
-check_for_test_error () {
-	if [ "${HEALTH}" != "Complete" ]; then
-		return 0
-	else
-		return 1
-	fi
-}
+get_first_xml_attr_value() {
+	file=${1}
+	tag=${2}
 
-# $1: LAVA job ID to show results for
-get_test_result () {
-	if [ -n "${1}" ]; then
-		# shellcheck disable=2086
-		lavacli "$LAVACLI_ARGS" results "${1}"
-	fi
+	grep -m 1 -o "${tag}=\".*\"" "${file}" | cut -d\" -f2
 }
 
 get_junit_test_results () {
 	mkdir -p "${RESULTS_DIR}"
 	curl -s -o "${RESULTS_DIR}"/results_"$1".xml "${LAVA_API_URL}"/jobs/"$1"/junit/
-}
 
-# $1: Test to print before job summary
-# $2: Set to true to print results for the job
-print_status () {
-	if [ -z "${1}" ]; then
-	# Set default text
-		local message="Current job status:"
-	else
-		local message="${1}"
+	# change return code to generate a error in gitlab-ci if a test is failed
+	errors=$(get_first_xml_attr_value "${RESULTS_DIR}"/results_"$1".xml errors)
+	failures=$(get_first_xml_attr_value "${RESULTS_DIR}"/results_"$1".xml failures)
+	if [ "${errors}" -gt "0" ] || [ "${failures}" -gt "0" ]; then
+		ERROR=true
 	fi
-
-	echo "------------------------------"
-	echo "${message}"
-	echo "------------------------------"
-	echo "Job #$2: ${STATUS}"
-	echo "Health: ${HEALTH}"
-	echo "Device: ${DEVICE}"
-	echo "Test: ${TESTING}"
-	echo "URL: ${LAVA_JOBS_URL}/$2"
-	if [ -n "${2}" ]; then
-		get_test_result "$2"
-	fi
-	echo " "
-}
-
-print_summary () {
-	echo "------------------------------"
-	echo "Job Summary"
-	echo "------------------------------"
-	echo "Job #${1} ${STATUS}. Job health: ${HEALTH}. URL: ${LAVA_JOBS_URL}/${1}"
-}
-
-check_status () {
-	local end_time status now
-	if [ -n "$TEST_TIMEOUT" ]; then
-		# Current time + timeout time
-		end_time=$(date +%s -d "+ $TEST_TIMEOUT min")
-	fi
-
-	local error=false
-
-	if [ -n "$1" ]; then
-		print_status "Current job status:"
-		while true
-		do
-			# Get latest status
-			if [ "${STATUS}" != "Finished" ]
-			then
-				local lavacli_output=${job_dir}/lavacli_output
-				# shellcheck disable=2086
-				lavacli $LAVACLI_ARGS jobs show "$1" \
-					> "$lavacli_output"
-
-				status=$(grep "state" "$lavacli_output" \
-					| cut -d ":" -f 2 \
-					| awk '{$1=$1};1')
-
-				HEALTH=$(grep "Health" "$lavacli_output" \
-					| cut -d ":" -f 2 \
-					| awk '{$1=$1};1')
-
-				DEVICE=$(grep "device      :" "$lavacli_output" \
-					| cut -d ":" -f 2 \
-					| awk '{$1=$1};1')
-
-				if [ "${STATUS}" != "$status" ]; then
-					STATUS=$status
-
-					# Something has changed
-					print_status "Current job status:" "$1"
-				else
-					STATUS=$status
-				fi
-			fi
-
-			if check_if_finished; then
-				break
-			fi
-
-			if [ -n "$TEST_TIMEOUT" ]; then
-				# Check timeout
-				now=$(date +%s)
-				if [ "$now" -ge "$end_time" ]; then
-					echo "Timed out waiting for test jobs to complete"
-					error=true
-					break
-				fi
-			fi
-
-			# Wait to avoid spamming the server too hard
-			sleep 60
-		done
-
-		if check_if_finished; then
-			# Print job outcome
-			print_status "Final job status:" "$1"
-
-			if check_for_test_error; then
-				error=true
-			fi
-		fi
-	fi
-
-	if $error; then
-		echo "---------------------"
-		echo "Errors during testing"
-		echo "---------------------"
-		print_summary "$1"
-		clean_up
-		return 1
-	fi
-
-	echo "-----------------------------------"
-	echo "Submitted test is successful"
-	echo "-----------------------------------"
-	print_summary "$1"
-	return 0
 }
 
 set_up
-- 
2.43.0


