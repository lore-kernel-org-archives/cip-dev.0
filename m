Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFFC27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 18:21:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.64710.1718648517129282566
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 11:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 45HILthK089879; Tue, 18 Jun 2024 03:21:55 +0900
X-Iguazu-Qid: 2yAbLYkr6gFM1sD2H2
X-Iguazu-QSIG: v=2; s=0; t=1718648514; q=2yAbLYkr6gFM1sD2H2; m=h/reqMTqzlkrA/myZ5RvOuTDIaSAx1IzCkfIUUs9NHU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 45HILsZp2517588
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:21:54 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 2/3] submit_lava.sh: Modify the script to handle only one job at a time
Date: Mon, 17 Jun 2024 23:51:46 +0530
X-TSB-HOP2: ON
Message-Id: <20240617182147.1724078-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Jun 2024 18:21:45.0863 (UTC) FILETIME=[3619F170:01DAC0E3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 18:21:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16266

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 336 ++++++++++++++++-------------------------
 1 file changed, 132 insertions(+), 204 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index a22fba7..9cf2c58 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -20,17 +20,18 @@ WORK_DIR=$(pwd)
 RESULTS_DIR="$WORK_DIR/results"
 ERROR=false
 TEST=$1
-COMMIT_REF=$2
-RELEASE=$3
-COMMIT_BRANCH=$4
+TARGET=$2
+COMMIT_REF=$3
+RELEASE=$4
+COMMIT_BRANCH=$5
 
 if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
 # Create a dictionary to handle image arguments based on architecture
 declare -A image_args
-image_args[amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
-image_args[arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
-image_args[arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
+image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
+image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
+image_args[qemu-arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 
 set_up (){
 	echo "Installing dependencies to run this script..."
@@ -44,83 +45,51 @@ clean_up () {
 
 # This method is called only for arm64 and arm targets while building job definitions
 add_firmware_artifacts () {
-	sed -i "s@#Firmware#@firmware:@g" "$2"
-	sed -i "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" "$2"
-	sed -i "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/qemu-${1}/firmware.bin@g" "$2"
+	sed -i "s@#Firmware#@firmware:@g" "$1"
+	sed -i "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" "$1"
+	sed -i "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/${2}/firmware.bin@g" "$1"
 }
 
 # This method creates LAVA job definitions for QEMU amd64, arm64 and armhf
 # The created job definitions test SWUpdate, Secureboot and IEC layer
-create_jobs () {
-	if [ "$1" = "IEC_Layer_test" ]; then
-		for arch in amd64 arm64 arm
-		do
-			cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}"/IEC_${arch}.yml
-
-			if [ $arch != amd64 ]; then
-				add_firmware_artifacts $arch "${job_dir}"/IEC_${arch}.yml
-			fi
-		done
-
-	elif [ "$1" = "software_update_test" ]; then
-		if [ -z "$2" ]; then
-			for arch in amd64 arm64 arm
-			do
-				cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/swupdate_${arch}.yml
-
-				if [ $arch != amd64 ]; then
-					add_firmware_artifacts $arch "${job_dir}"/swupdate_${arch}.yml
-				fi
-			done
+create_job () {
+	if [ "$1" = "IEC" ]; then
+		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}"/${1}_${2}.yml
+
+	elif [ "$1" = "swupdate" ]; then
+		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/${1}_${2}.yml
+
+	elif [ "$1" = "kernel-panic" ] || [ "$1" = "initramfs-crash" ]; then
+		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/"${1}".yml
+		sed -i "s@software update testing@${1}_rollback_testing@g" "${job_dir}"/*.yml
+		sed -i "s@) = 2@) = 0@g" "${job_dir}"/*.yml
+		if [ "$1" = "kernel-panic" ]; then
+			sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" "${job_dir}"/*.yml
+			sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/*.yml
 		else
-			cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/"${2}"_amd64.yml
-			sed -i "s@software update testing@${2}@g" "${job_dir}"/"${2}"_amd64.yml
-			sed -i "s@) = 2@) = 0@g" "${job_dir}"/"${2}"_amd64.yml
-			if [ "$2" = "kernel_panic" ]; then
-				sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" "${job_dir}"/"${2}"_amd64.yml
-			else
-				sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" "${job_dir}"/"${2}"_amd64.yml
-				sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/"${2}"_amd64.yml
-			fi
+			sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" "${job_dir}"/*.yml
+			sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/*.yml
 		fi
 	else
-		for arch in amd64 arm64 arm
-		do
-			cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}"/secureboot_${arch}.yml
-
-			if [ $arch != amd64 ]; then
-				add_firmware_artifacts $arch "${job_dir}"/secureboot_${arch}.yml
-			fi
-		done
+		cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}"/${1}_${2}.yml
 	fi
 
-	if [ "$2" = "kernel_panic" ]; then
-		sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/"${2}"_amd64.yml
-	elif [ "$2" = "kernel_panic" ]; then
-		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/"${2}"_amd64.yml
-	else
+	if [ "$1" != "kernel-panic" ]; then
 		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/*.yml
 	fi
-	sed -i "s@#distribution#@${release}@g" "${job_dir}"/*.yml
-	sed -i "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
 
-	for arch in amd64 arm64 arm
-	do
-		sed -i "s@#architecture#@${arch}@g" "${job_dir}"/*${arch}.yml
-		sed -i "s@#imageargs#@${image_args[$arch]}@g" "${job_dir}"/*${arch}.yml
-	done
-}
-
-create_cip_core_jobs () {
-	if [ "$TEST" = "IEC" ]; then
-		create_jobs IEC_Layer_test
-	elif [ "$TEST" = "swupdate" ]; then
-		create_jobs software_update_test
-		create_jobs software_update_test kernel_panic
-		create_jobs software_update_test initramfs_crash
-	else
-		create_jobs secure_boot_test
+	if [ "$2" != "qemu-amd64" ]; then
+		add_firmware_artifacts "${job_dir}"/*.yml $2
 	fi
+
+	sed -i -e "s@#distribution#@${RELEASE}@g" -e "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
+	sed -i -e "s@#architecture#@${2}@g" -e "s@#imageargs#@${image_args[$2]}@g" "${job_dir}"/*.yml
+
+	# Target is recieved from gitlab job in form of qemu-"architecture"
+	# In the template context field needs only architecture excepting the device type
+	local arch
+	arch=$(echo ${2} | cut -d '-' -f 2)
+	sed -i "s@#context-architecture#@${arch}@g" "${job_dir}"/*.yml
 }
 
 # This method attaches SQUAD watch job to the submitted LAVA job
@@ -165,16 +134,19 @@ submit_squad_watch_job(){
 
 # $1: Job definition file
 submit_job() {
-        # Make sure yaml file exists
-	if [ -f "$1" ]; then
+        # First check if respective device is online
+	local job device ret status health device test
+	job=$1
+	device=$(grep device_type "$job" | cut -d ":" -f 2 | awk '{$1=$1};1')
+	if is_device_online "$device"; then
 		echo "Submitting $1 to LAVA master..."
 		# Catch error that occurs if invalid yaml file is submitted
-		local ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=true
+		ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=true
 
 		if [[ $ret != [0-9]* ]]
 		then
 			echo "Something went wrong with job submission. LAVA returned:"
-			echo "${ret}"
+			return 1
 		else
 			echo "Job submitted successfully as #${ret}."
 
@@ -182,52 +154,51 @@ submit_job() {
 			lavacli $LAVACLI_ARGS jobs show "${ret}" \
 				> "$lavacli_output"
 
-			local status=$(cat "$lavacli_output" \
+			status=$(cat "$lavacli_output" \
 				| grep "state" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
-			STATUS[${ret}]=$status
+			STATUS=$status
 
-			local health=$(cat "$lavacli_output" \
+			health=$(cat "$lavacli_output" \
 				| grep "Health" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
-			HEALTH[${ret}]=$health
-
-			local device_type=$(cat "$lavacli_output" \
-				| grep "device-type" \
-				| cut -d ":" -f 2 \
-				| awk '{$1=$1};1')
-			DEVICE_TYPE[${ret}]=$device_type
+			HEALTH=$health
 
-			local device=$(cat "$lavacli_output" \
+			device=$(cat "$lavacli_output" \
 				| grep "device      :" \
 				| cut -d ":" -f 2 \
 				| awk '{$1=$1};1')
-			DEVICE[${ret}]=$device
+			DEVICE=$device
 
-			local test=$(cat "$lavacli_output" \
+			test=$(cat "$lavacli_output" \
 				| grep "description" \
 				| rev | cut -d "_" -f 1 | rev)
-			TEST[${ret}]=$test
+			TESTING=$test
 
 			submit_squad_watch_job "${ret}" "${device}"
 
-			JOBS+=("${ret}")
-
+			if ! check_status $ret; then
+				ERROR=true
+			fi
+			get_junit_test_results $ret
 		fi
+	else
+		return 1
 	fi
 }
 
 # $1: Device-type to search for
 is_device_online () {
+	local count
 	local lavacli_output=${job_dir}/lavacli_output
 
 	# Get list of all devices
 	lavacli $LAVACLI_ARGS devices list > "$lavacli_output"
 
 	# Count the number of online devices
-	local count=$(grep "(${1})" "$lavacli_output" | grep -c "Good")
+	count=$(grep "(${1})" "$lavacli_output" | grep -c "Good")
 	echo "There are currently $count \"${1}\" devices online."
 
 	if [ "$count" -gt 0 ]; then
@@ -236,20 +207,6 @@ is_device_online () {
 	return 1
 }
 
-submit_jobs () {
-	local ret=0
-	for JOB in "${job_dir}"/*.yml; do
-		local device=$(grep device_type "$JOB" | cut -d ":" -f 2 | awk '{$1=$1};1')
-		if is_device_online "$device"; then
-			submit_job "$JOB"
-		else
-			echo "Refusing to submit test job as there are no suitable devices available."
-			ret=1
-		fi
-	done
-	return $ret
-}
-
 # This method is added with the intention to check if all the jobs are valid before submit
 # If even a single definition is found to be invalid, then no job shall be submitted until
 # it is fixed by the maintainer
@@ -258,6 +215,10 @@ validate_jobs () {
 	for JOB in "${job_dir}"/*.yml; do
 		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
 			echo "$JOB is a valid definition"
+			if ! submit_job $JOB; then
+				clean_up
+				exit 1
+			fi
 		else
 			echo "$JOB is not a valid definition"
 			ret=1
@@ -266,22 +227,20 @@ validate_jobs () {
 	return $ret
 }
 
-check_if_all_finished () {
-	for i in "${JOBS[@]}"; do
-		if [ "${STATUS[$i]}" != "Finished" ]; then
-			return 1
-		fi
-	done
-	return 0
+check_if_finished () {
+	if [ "${STATUS}" != "Finished" ]; then
+		return 1
+	else
+		return 0
+	fi
 }
 
 check_for_test_error () {
-	for i in "${JOBS[@]}"; do
-		if [ "${HEALTH[$i]}" != "Complete" ]; then
-			return 0
-		fi
-	done
-	return 1
+	if [ "${HEALTH}" != "Complete" ]; then
+		return 0
+	else
+		return 1
+	fi
 }
 
 # $1: LAVA job ID to show results for
@@ -293,13 +252,11 @@ get_test_result () {
 
 get_junit_test_results () {
 	mkdir -p "${RESULTS_DIR}"
-	for i in "${JOBS[@]}"; do
-		curl -s -o "${RESULTS_DIR}"/results_"$i".xml "${LAVA_API_URL}"/jobs/"$i"/junit/
-	done
+	curl -s -o "${RESULTS_DIR}"/results_"$1".xml "${LAVA_API_URL}"/jobs/"$1"/junit/
 }
 
-# $1: Test to print before job summaries
-# $2: Set to true to print results for each job
+# $1: Test to print before job summary
+# $2: Set to true to print results for the job
 print_status () {
 	if [ -z "${1}" ]; then
 	# Set default text
@@ -311,94 +268,78 @@ print_status () {
 	echo "------------------------------"
 	echo "${message}"
 	echo "------------------------------"
-	for i in "${JOBS[@]}"; do
-		echo "Job #$i: ${STATUS[$i]}"
-		echo "Health: ${HEALTH[$i]}"
-		echo "Device Type: ${DEVICE_TYPE[$i]}"
-		echo "Device: ${DEVICE[$i]}"
-		echo "Test: ${TEST[$i]}"
-		echo "URL: ${LAVA_JOBS_URL}/$i"
-		if [ -n "${2}" ]; then
-			get_test_result "$i"
-		fi
-		echo " "
-	done
+	echo "Job #$2: ${STATUS}"
+	echo "Health: ${HEALTH}"
+	echo "Device: ${DEVICE}"
+	echo "Test: ${TESTING}"
+	echo "URL: ${LAVA_JOBS_URL}/$2"
+	if [ -n "${2}" ]; then
+		get_test_result "$2"
+	fi
+	echo " "
 }
 
 print_summary () {
 	echo "------------------------------"
 	echo "Job Summary"
 	echo "------------------------------"
-	for i in "${JOBS[@]}"
-	do
-		echo "Job #${i} ${STATUS[$i]}. Job health: ${HEALTH[$i]}. URL: ${LAVA_JOBS_URL}/${i}"
-	done
+	echo "Job #${1} ${STATUS}. Job health: ${HEALTH}. URL: ${LAVA_JOBS_URL}/${1}"
 }
 
 check_status () {
+	local end_time status health device now
 	if [ -n "$TEST_TIMEOUT" ]; then
 		# Current time + timeout time
-		local end_time=$(date +%s -d "+ $TEST_TIMEOUT min")
+		end_time=$(date +%s -d "+ $TEST_TIMEOUT min")
 	fi
 
 	local error=false
 
-	if [ ${#JOBS[@]} -ne 0 ]
-	then
-
+	if [ ! -z $1 ]; then
 		print_status "Current job status:"
 		while true
 		do
 			# Get latest status
-			for i in "${JOBS[@]}"
-			do
-				if [ "${STATUS[$i]}" != "Finished" ]
-				then
-					local lavacli_output=${job_dir}/lavacli_output
-					lavacli $LAVACLI_ARGS jobs show "$i" \
-						> "$lavacli_output"
-
-					local status=$(cat "$lavacli_output" \
-						| grep "state" \
-						| cut -d ":" -f 2 \
-						| awk '{$1=$1};1')
-
-					local health=$(cat "$lavacli_output" \
-						| grep "Health" \
-						| cut -d ":" -f 2 \
-						| awk '{$1=$1};1')
-					HEALTH[$i]=$health
-
-					local device_type=$(cat "$lavacli_output" \
-						| grep "device-type" \
-						| cut -d ":" -f 2 \
-						| awk '{$1=$1};1')
-					DEVICE_TYPE[$i]=$device_type
-
-					local device=$(cat "$lavacli_output" \
-						| grep "device      :" \
-						| cut -d ":" -f 2 \
-						| awk '{$1=$1};1')
-					DEVICE[$i]=$device
-
-					if [ "${STATUS[$i]}" != "$status" ]; then
-						STATUS[$i]=$status
-
-						# Something has changed
-						print_status "Current job status:"
-					else
-						STATUS[$i]=$status
-					fi
+			if [ "${STATUS}" != "Finished" ]
+			then
+				local lavacli_output=${job_dir}/lavacli_output
+				lavacli $LAVACLI_ARGS jobs show "$1" \
+					> "$lavacli_output"
+
+				status=$(cat "$lavacli_output" \
+					| grep "state" \
+					| cut -d ":" -f 2 \
+					| awk '{$1=$1};1')
+
+				health=$(cat "$lavacli_output" \
+					| grep "Health" \
+					| cut -d ":" -f 2 \
+					| awk '{$1=$1};1')
+				HEALTH=$health
+
+				device=$(cat "$lavacli_output" \
+					| grep "device      :" \
+					| cut -d ":" -f 2 \
+					| awk '{$1=$1};1')
+				DEVICE=$device
+
+				if [ "${STATUS}" != "$status" ]; then
+					STATUS=$status
+
+					# Something has changed
+					print_status "Current job status:" $1
+				else
+					STATUS=$status
 				fi
-			done
+			fi
 
-			if check_if_all_finished; then
+			if check_if_finished; then
 				break
 			fi
 
 			if [ -n "$TEST_TIMEOUT" ]; then
 				# Check timeout
-				local now=$(date +%s)
+				now=$(date +%s)
 				if [ "$now" -ge "$end_time" ]; then
 					echo "Timed out waiting for test jobs to complete"
 					error=true
@@ -410,9 +351,9 @@ check_status () {
 			sleep 60
 		done
 
-		if check_if_all_finished; then
+		if check_if_finished; then
 			# Print job outcome
-			print_status "Final job status:" true
+			print_status "Final job status:" $1
 
 			if check_for_test_error; then
 				error=true
@@ -424,39 +365,26 @@ check_status () {
 		echo "---------------------"
 		echo "Errors during testing"
 		echo "---------------------"
-		print_summary
+		print_summary $1
 		clean_up
 		return 1
 	fi
 
 	echo "-----------------------------------"
-	echo "All submitted tests were successful"
+	echo "Submitted test is successful"
 	echo "-----------------------------------"
-	print_summary
+	print_summary $1
 	return 0
 }
 
 set_up
-create_cip_core_jobs
+create_job $TEST $TARGET
 
 if ! validate_jobs; then
 	clean_up
 	exit 1
 fi
 
-if ! submit_jobs; then
-        clean_up
-        exit 1
-fi
-
-if ! $SUBMIT_ONLY; then
-	if ! check_status; then
-		ERROR=true
-	fi
-
-	get_junit_test_results
-fi
-
 clean_up
 
 if $ERROR; then
-- 
2.30.2



