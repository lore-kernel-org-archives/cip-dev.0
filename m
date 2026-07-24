Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49287C53209
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 10:51:25 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16734.1784890280853108403
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Hybe6CO+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2026072410511750724ea797000207aa-pzwjvn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026072410511750724ea797000207aa
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 12:51:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=a+sk+hk+XiGc1sSPtvnoSSE2fykrtFZuzuP+dNwJ8oE=;
 b=Hybe6CO+VTJlDV2HLhtmmKtHS1LT7am/PtLLqihNbl5cyLooFbYDVuK90dAOaP4h2G6rpu
 Zd0GzpPIhhl1e+dIrKLHGrDhM5+KwgE3PEl2RRN1UHoz1kUJGqJejmBXKWZlYpwcIAmquylt
 hF8fRLx6yz0ej4i+DUW5l+1GdXcxA6Bo4tJ6qwIDjmv/uRzx1l+qDYcNQcRIPCpLNO14ViRY
 p6+yIx3NNx6eZ0f6G3aQL3H+loo7xO8caJ00hrMfzOInyBYv3tZI2+0fAc4Jo4lTK1nO+PN1
 L/s9YKaHDqqlJLeQk1G5KW2jenMpDTkO+TCMRybgtzLMe4IKrEZKcPXA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 1/4] update to kas 5.4
Date: Fri, 24 Jul 2026 12:51:05 +0200
Message-ID: <20260724105116.3575045-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 10:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23733

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml |   2 +-
 kas-cip.yml    |   2 +-
 kas-container  | 311 ++++++++++++++++++++++++++-----------------------
 3 files changed, 170 insertions(+), 145 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b53def4..1e61cb0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -33,7 +33,7 @@ stages:
   - cve-check
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:5.2
+  image: ghcr.io/siemens/kas/kas-isar:5.4
   before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
diff --git a/kas-cip.yml b/kas-cip.yml
index 23bbba4..6badc7d 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -15,7 +15,7 @@ header:
 distro: cip-core-trixie
 target: cip-core-image
 
-build_system: isar
+build_system: isar-privileged
 
 repos:
   cip-core:
diff --git a/kas-container b/kas-container
index 993f0bb..55bdcfc 100755
--- a/kas-container
+++ b/kas-container
@@ -27,7 +27,7 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="5.2"
+KAS_CONTAINER_SCRIPT_VERSION="5.4"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
 KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=""
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
@@ -49,9 +49,10 @@ usage()
 	printf "%b" "\nPositional arguments:\n"
 	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
 	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
+	printf "%b" "diff\t\t\tCompare two kas configurations.\n"
 	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
 	printf "%b" "    \t\t\tof config to stdout.\n"
-	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
+	printf "%b" "lock\t\t\tCreate and update kas project lockfiles.\n"
 	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
 	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
 	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
@@ -61,20 +62,19 @@ usage()
 	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
 		    "downloads.\n"
 	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-run'\n"
-	printf "%b" "     \t\t\tto check what would be removed\n"
+	printf "%b" "     \t\t\tto check what would be removed.\n"
 	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
 		    "configured build.\n"
 	printf "%b" "\nOptional arguments:\n"
-	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To force\n"
-	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=run0.\n"
-	printf "%b" "--with-loop-dev		Pass a loop device to the " \
-		    "container. Only required if\n"
-	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
+	printf "%b" "--isar-privileged\tRun an Isar build in privileged mode. " \
+	            "To force the use\n"
+	printf "%b" "\t\t\tof run0 over sudo, set KAS_SUDO_CMD=run0.\n"
+	printf "%b" "--isar-rootless\t\tRun an Isar build in rootless mode.\n"
 	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
-			"container runtime\n"
+			"container runtime.\n"
 	printf "%b" "\t\t\tfor running the build.\n"
 	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
-	printf "%b" "--version\t\tprint program version.\n"
+	printf "%b" "--version\t\tPrint program version.\n"
 	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
 	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
 		    "container.\n"
@@ -83,13 +83,15 @@ usage()
 	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
 		    "container.\n"
 	printf "%b" "--git-credential-store\tFile path to the git credential " \
-		    "store\n"
+		    "store.\n"
+	printf "%b" "--git-credential-socket\tPath to the git credential cache " \
+	       "socket.\n"
 	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
 		    "environment.\n"
 	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
-		    "\t\t\t(default for build command)\n"
+		    "\t\t\t(default for build command).\n"
 	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
-		    "\t\t\t(default for shell command)\n"
+		    "\t\t\t(default for shell command).\n"
 	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
 	printf "%b" "\n"
 	printf "%b" "You can force the use of podman over docker using " \
@@ -143,11 +145,6 @@ prepare_sudo_cmd()
 
 enable_isar_mode()
 {
-	if [ -n "${ISAR_MODE}" ]; then
-		return
-	fi
-	ISAR_MODE=1
-
 	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
 	KAS_ISAR_ARGS="--privileged"
 
@@ -159,14 +156,38 @@ enable_isar_mode()
 		export PATH="${PATH}:/usr/sbin"
 	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
 		prepare_sudo_cmd
-		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
-		debug "kas-isar does not support rootless docker. Using system docker"
+		DOCKER_HOST_DEFAULT="$(docker context inspect default --format '{{.Endpoints.docker.Host}}')"
+		export DOCKER_HOST="${DOCKER_HOST:-$DOCKER_HOST_DEFAULT}"
+		debug "kas-isar does not support rootless docker. Using system docker in $DOCKER_HOST"
 		# force use of well-known system docker socket
 		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
 		KAS_DOCKER_ROOTLESS=0
 	fi
 }
 
+enable_isar_rootless_mode()
+{
+	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
+
+	# Use --privileged to pass the ambient capabilities into the container.
+	# When calling from the user session (podman or docker-rootless), this
+	# is fundamentally different from the system docker run --privileged
+	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id --privileged"
+	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+		KAS_ISAR_ARGS="--privileged"
+	else
+		# we don't need --privileged, but we need to run with SYS_ADMIN
+		# to be able to unshare.
+		KAS_ISAR_ARGS=" \
+			--security-opt seccomp=unconfined \
+			--security-opt apparmor=unconfined \
+			--security-opt systempaths=unconfined \
+			--cap-add=SYS_ADMIN \
+		"
+	fi
+}
+
 enable_oe_mode()
 {
 	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
@@ -174,6 +195,7 @@ enable_oe_mode()
 		# calling "podman run" has a 1:1 mapping
 		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
 	fi
+	BUILD_SYSTEM="openembedded"
 }
 
 enable_unpriv_userns_docker()
@@ -210,6 +232,20 @@ check_and_expand()
 	realpath -e "$_varval"
 }
 
+# SC2034: DIR appears unused (ignore, as they are used inside eval)
+# shellcheck disable=2034
+setup_kas_dirs()
+{
+	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
+	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
+	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
+	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
+	DL_DIR="$(check_and_expand DL_DIR createrec)"
+	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
+	BB_HASHSERVE_DB_DIR="$(check_and_expand BB_HASHSERVE_DB_DIR createrec)"
+	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
+}
+
 # Params: FILE
 # Returns: root repo dir of file
 repo_path_of_file()
@@ -260,14 +296,6 @@ forward_dir()
 	fi
 }
 
-check_docker_rootless()
-{
-	KAS_DOCKER_ROOTLESS=0
-	if [ "$(docker context show)" = "rootless" ]; then
-		KAS_DOCKER_ROOTLESS=1
-	fi
-}
-
 enable_docker_rootless()
 {
 	warning "Rootless docker used, only limited functionality available."
@@ -281,122 +309,48 @@ enable_docker_rootless()
 	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=1"
 }
 
-KAS_GIT_OVERLAY_FILE=""
-kas_container_cleanup()
-{
-	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
-		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
-	fi
-}
-trap kas_container_cleanup EXIT INT TERM
-
 set_container_image_var()
 {
+	# if the image is explicitly set, use that
+	if [ -n "${KAS_CONTAINER_IMAGE}" ]; then
+		return
+	fi
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_DISTRO="${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAINER_IMAGE_DISTRO_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
-	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
-	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
+	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
 	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
 		KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DISTRO}"
 	fi
 }
 
-# SC2034: DIR appears unused (ignore, as they are used inside eval)
-# shellcheck disable=2034
-setup_kas_dirs()
-{
-	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
-	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
-	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
-	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
-	DL_DIR="$(check_and_expand DL_DIR createrec)"
-	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
-	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
-}
-setup_kas_dirs
-
-KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
-if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
-	# Try to auto-detect a container engine
-	if command -v docker >/dev/null; then
-		case $(docker -v 2>/dev/null) in
-		podman*)
-			# The docker command is an alias for podman
-			KAS_CONTAINER_ENGINE=podman
-			;;
-		Docker*)
-			# The docker command is the real docker
-			KAS_CONTAINER_ENGINE=docker
-			;;
-		*)
-			# The docker command is an unknown engine
-			fatal_error "docker command found, but unknown engine detected"
-		esac
-	elif command -v podman >/dev/null; then
-		KAS_CONTAINER_ENGINE=podman
-	else
-		fatal_error "no container engine found, need docker or podman"
-	fi
-fi
-
-KAS_RUNTIME_ARGS="--log-driver=none --user=root"
-
-case "${KAS_CONTAINER_ENGINE}" in
-docker)
-	KAS_CONTAINER_COMMAND="docker"
-	enable_unpriv_userns_docker
-	check_docker_rootless
-	;;
-podman)
-	KAS_CONTAINER_COMMAND="podman"
-	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
-	;;
-*)
-	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
-	;;
-esac
-
-# parse kas-container options
+# parse kas-container options, leave build system empty to distinguish between
+# explicitly set via flag and implicitly via config.
+BUILD_SYSTEM=""
+KAS_OPTIONS_DIRECT=""
+KAS_EXTRA_RUNTIME_ARGS=""
 while [ $# -gt 0 ]; do
 	case "$1" in
-	--isar)
-		enable_isar_mode
+	--isar | --isar-privileged)
+		if [ "$1" = "--isar" ]; then
+			warning "The semantic of '--isar' might change in the" \
+				"future. Please use '--isar-privileged' instead."
+		fi
+		BUILD_SYSTEM="isar-privileged"
 		shift 1
 		;;
-	--with-loop-dev)
-		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
-			if [ "$(id -u)" -eq 0 ]; then
-				fatal_error "loop device not available!"
-			fi
-			prepare_sudo_cmd
-			if ! [ "$KAS_SUDO_CMD" = "sudo" ]; then
-				fatal_error '--with-loop-dev requires sudo for device setup.'
-			fi
-			sudo_command="/sbin/losetup -f"
-			sudo_message="[sudo] enter password to setup loop"
-			sudo_message="$sudo_message devices by calling"
-			sudo_message="$sudo_message '$sudo_command': "
-			# SC2086: Double quote to prevent globbing and word splitting.
-			# shellcheck disable=2086
-			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
-				2>/dev/null); then
-				fatal_error "loop device setup unsuccessful!" \
-				            "try calling '$sudo_command' with root" \
-				            "permissions manually."
-			fi
-		fi
-		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
+	--isar-rootless)
+		BUILD_SYSTEM="isar-rootless"
 		shift 1
 		;;
-	--runtime-args|--docker-args)
-		[ $# -gt 0 ] || usage
-		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} $2"
+	--runtime-args | --docker-args)
+		[ $# -gt 1 ] || usage
+		KAS_EXTRA_RUNTIME_ARGS="${KAS_EXTRA_RUNTIME_ARGS} $2"
 		shift 2
 		;;
 	--ssh-dir)
-		[ $# -gt 2 ] || usage
+		[ $# -gt 1 ] || usage
 		KAS_SSH_DIR="$2"
 		shift 2
 		;;
@@ -408,15 +362,22 @@ while [ $# -gt 0 ]; do
 		shift 1
 		;;
 	--aws-dir)
-		[ $# -gt 2 ] || usage
+		[ $# -gt 1 ] || usage
 		KAS_AWS_DIR="$2"
 		shift 2
 		;;
 	--git-credential-store)
-		[ $# -gt 2 ] || usage
+		[ $# -gt 1 ] || usage
 		KAS_GIT_CREDENTIAL_STORE="$2"
 		shift 2
 		;;
+
+	--git-credential-socket)
+		[ $# -gt 1 ] || usage
+		KAS_GIT_CREDENTIAL_SOCKET="$2"
+		shift 2
+		;;
+
 	--no-proxy-from-env)
 		KAS_NO_PROXY_FROM_ENV=1
 		shift 1
@@ -446,19 +407,19 @@ while [ $# -gt 0 ]; do
 	--*)
 		usage
 		;;
-	clean|cleansstate|cleanall|purge)
+	clean | cleansstate | cleanall | purge)
 		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 		KAS_CMD=$1
 		shift 1
 		break
 		;;
-	shell|lock)
+	shell | lock)
 		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
 		KAS_CMD=$1
 		shift 1
 		break
 		;;
-	build|checkout|for-all-repos|menu)
+	build | checkout | for-all-repos | menu)
 		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
 		KAS_CMD=$1
 		shift 1
@@ -486,6 +447,10 @@ while [ $# -gt 0 ]; do
 	esac
 done
 
+KAS_RUNTIME_ARGS="--log-driver=none --user=root"
+
+setup_kas_dirs
+
 [ -n "${KAS_CMD}" ] || usage
 
 KAS_EXTRA_BITBAKE_ARGS=0
@@ -494,17 +459,17 @@ KAS_FILES=
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
 	case "$1" in
-	--format|--indent|--provenance|--skip|--target|--task)
+	--format | --indent | --provenance | --skip | --target | --task)
 		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
 		shift 1
 		shift 1 || KAS_OPTIONS="--help"
 		;;
-	-c|--cmd|--command)
+	-c | --cmd | --command)
 		KAS_BITBAKE_C_OPTION_ARGS="$2"
 		shift 1
 		shift 1 || KAS_OPTIONS="--help"
 		;;
-	-E|--preserve-env)
+	-E | --preserve-env)
 		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
 		;;
 	--)
@@ -563,10 +528,10 @@ if [ "${KAS_CMD}" = "menu" ]; then
 	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
 		fatal_error "menu plugin only supports a single Kconfig file"
 	fi
-	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
+	BUILD_SYSTEM=${BUILD_SYSTEM:-$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" |
 		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
 		    -e 's/\f\([[:alpha:]].*\|$\)//' \
-		    -e 's/.*default \"\(.*\)\".*/\1/')
+		    -e 's/.*default \"\(.*\)\".*/\1/')}
 else
 	if [ -z "${KAS_FIRST_FILES}" ]; then
 		KAS_FIRST_FILES="${KAS_WORK_DIR}/.config.yaml"
@@ -574,20 +539,60 @@ else
 
 	# We only get the first build system and let kas check if mixed
 	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
-	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
-		sed 's/build_system:[ ]\+//')
+	BUILD_SYSTEM=${BUILD_SYSTEM:-$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null |
+		sed 's/build_system:[ ]\+//')}
 fi
 
-if [ "${BUILD_SYSTEM}" = "isar" ]; then
+KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
+if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
+	# Try to auto-detect a container engine
+	# Defaults if there are multiple options:
+	# podman if build system is isar-rootless, docker otherwise
+	if [ "${BUILD_SYSTEM}" = "isar-rootless" ] && command -v podman >/dev/null 2>&1; then
+		KAS_CONTAINER_ENGINE=podman
+	elif command -v docker >/dev/null 2>&1 && docker -v 2>/dev/null | grep -q '^Docker'; then
+		KAS_CONTAINER_ENGINE=docker
+	elif command -v podman >/dev/null 2>&1; then
+		KAS_CONTAINER_ENGINE=podman
+	else
+		fatal_error "no container engine found, need docker or podman"
+	fi
+fi
+
+KAS_DOCKER_ROOTLESS=0
+case "${KAS_CONTAINER_ENGINE}" in
+docker)
+	KAS_CONTAINER_COMMAND="docker"
+	enable_unpriv_userns_docker
+	if [ "$(docker context show)" = "rootless" ]; then
+		KAS_DOCKER_ROOTLESS=1
+	fi
+	;;
+podman)
+	KAS_CONTAINER_COMMAND="podman"
+	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
+	;;
+*)
+	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
+	;;
+esac
+
+if [ "${BUILD_SYSTEM}" = "isar" ] || [ "${BUILD_SYSTEM}" = "isar-privileged" ]; then
 	enable_isar_mode
-elif [ -z "${ISAR_MODE}" ]; then
+elif [ "${BUILD_SYSTEM}" = "isar-rootless" ]; then
+	enable_isar_rootless_mode
+else
 	enable_oe_mode
 fi
 
 # clean can be executed without config, hence manually forward the build system
-if [ "${ISAR_MODE}" = "1" ] && echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
-	KAS_OPTIONS="${KAS_OPTIONS} --isar"
-fi
+case "${BUILD_SYSTEM}" in
+isar*)
+	if echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
+		KAS_OPTIONS="${KAS_OPTIONS} --${BUILD_SYSTEM}"
+	fi
+	;;
+esac
 
 set_container_image_var
 
@@ -628,10 +633,21 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
 forward_dir DL_DIR "/downloads" "rw"
 forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
 forward_dir SSTATE_DIR "/sstate" "rw"
+forward_dir BB_HASHSERVE_DB_DIR "/bb-hashserve-db" "rw"
 forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
 
 if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
 	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
+
+	KAS_GIT_OVERLAY_FILE=""
+	kas_container_cleanup()
+	{
+		if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
+			trace rm -f "${KAS_GIT_OVERLAY_FILE}"
+		fi
+	}
+	trap kas_container_cleanup EXIT INT TERM
+
 	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
 	# we have to mount the common dir in the container to make git work
 	# The mount path inside the container is different from the host path. Hence, we over-mount
@@ -685,6 +701,14 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
 	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
 fi
 
+if [ -n "${KAS_GIT_CREDENTIAL_SOCKET}" ] ; then
+	if [ ! -S "${KAS_GIT_CREDENTIAL_SOCKET}" ]; then
+		fatal_error "passed KAS_GIT_CREDENTIAL_SOCKET '${KAS_GIT_CREDENTIAL_SOCKET}' is not a socket"
+	fi
+	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="cache --socket=/var/kas/userdata/.git-cache-socket"
+	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_SOCKET}")":/var/kas/userdata/.git-cache-socket
+fi
+
 GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
 
 if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
@@ -731,6 +755,7 @@ fi
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
            KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
            GIT_CREDENTIAL_USEHTTPPATH \
+           BB_HASHSERVE BB_HASHSERVE_UPSTREAM \
            TZ; do
 	if [ -n "$(eval echo \$${var})" ]; then
 		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
@@ -739,7 +764,7 @@ done
 
 # propagate only supported SHELL settings
 case "$SHELL" in
-/bin/sh|/bin/bash|/bin/dash)
+/bin/sh | /bin/bash | /bin/dash)
 	set -- "$@" -e "SHELL=$SHELL"
 	;;
 *)
@@ -757,7 +782,7 @@ fi
 
 # SC2086: Double quote to prevent globbing and word splitting.
 # shellcheck disable=2086
-set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
+set -- "$@" ${KAS_ISAR_ARGS} ${KAS_RUNTIME_ARGS} ${KAS_EXTRA_RUNTIME_ARGS} \
     ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
 if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
 	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
-- 
2.53.0


