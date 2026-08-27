Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E27AC61DCD
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:06 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30488.1787811781914430334
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=N0Wto5YO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202608270622588f34557eab000207c1-3zqohi@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202608270622588f34557eab000207c1
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Aug 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6HC3n72UKM8/SZpMsLA4oI0Yspzm1tINGhp3eMRNAfo=;
 b=N0Wto5YOkB8Gs1f9RDi83cQAexIoP9b5JTHpFunArP+zj6i9XuNAaOEVHwx5TRjMb0/IHh
 14rAEZDP7DsZLhYJ9jhY/bB3BAFGgG5cYigidNfQQaHzbBa6m6zl/5HByXJBIy8ao92GL951
 +aoIv/GRvuCL7qQ8ukt3wXsoTymH2nKGGP+UEtxFAPE7hfFzJmDC2N8wrsNxQFxRneevDfFR
 E6Wzd/bZqQxhGFkxK1N8XBURmwPq7L95JbbH67qjgZ+l/BwWeOH21gbKy2vPoivxWwGlGIfH
 MHDAzI1ExhpIwSOGLtFZxsh0W0jLXWK36RWjtxEqzVwAkEIdXEvgAZww==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/5] update to kas 5.5
Date: Thu, 27 Aug 2026 08:22:53 +0200
Message-ID: <d64f681bf40826549379ac49223cf8eb450260d5.1787811777.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787811777.git.jan.kiszka@siemens.com>
References: <cover.1787811777.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:23:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24036

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
[Jan: moved from 5.4 to 5.5]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |   2 +-
 Kconfig        |   2 +-
 kas-cip.yml    |   2 +-
 kas-container  | 329 +++++++++++++++++++++++++++----------------------
 4 files changed, 187 insertions(+), 148 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d46a9efb..9aa186c6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -34,7 +34,7 @@ stages:
   - cve-check
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:5.2
+  image: ghcr.io/siemens/kas/kas-isar:5.5
   before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
diff --git a/Kconfig b/Kconfig
index 19f8e24b..3a9444db 100644
--- a/Kconfig
+++ b/Kconfig
@@ -17,7 +17,7 @@ config KAS_INCLUDE_MAIN
 
 config KAS_BUILD_SYSTEM
 	string
-	default "isar"
+	default "isar-privileged"
 
 config ARCH_AMD64
 	bool
diff --git a/kas-cip.yml b/kas-cip.yml
index 7a3af452..97b333a1 100644
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
index 993f0bb8..d03717f0 100755
--- a/kas-container
+++ b/kas-container
@@ -27,7 +27,7 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="5.2"
+KAS_CONTAINER_SCRIPT_VERSION="5.5"
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
@@ -61,20 +62,21 @@ usage()
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
+	printf "%b" "--kvm\t\tPass /dev/kvm into the container (for runqemu/testimage KVM\n" \
+			"acceleration) and grant the build user access to it."
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
@@ -83,13 +85,15 @@ usage()
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
@@ -143,11 +147,6 @@ prepare_sudo_cmd()
 
 enable_isar_mode()
 {
-	if [ -n "${ISAR_MODE}" ]; then
-		return
-	fi
-	ISAR_MODE=1
-
 	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
 	KAS_ISAR_ARGS="--privileged"
 
@@ -159,14 +158,38 @@ enable_isar_mode()
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
@@ -174,6 +197,7 @@ enable_oe_mode()
 		# calling "podman run" has a 1:1 mapping
 		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
 	fi
+	BUILD_SYSTEM="openembedded"
 }
 
 enable_unpriv_userns_docker()
@@ -210,6 +234,20 @@ check_and_expand()
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
@@ -260,14 +298,6 @@ forward_dir()
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
@@ -281,122 +311,52 @@ enable_docker_rootless()
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
+		shift 1
+		;;
+	--kvm)
+		KAS_KVM="1"
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
@@ -408,15 +368,22 @@ while [ $# -gt 0 ]; do
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
@@ -446,19 +413,19 @@ while [ $# -gt 0 ]; do
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
@@ -486,6 +453,10 @@ while [ $# -gt 0 ]; do
 	esac
 done
 
+KAS_RUNTIME_ARGS="--log-driver=none --user=root"
+
+setup_kas_dirs
+
 [ -n "${KAS_CMD}" ] || usage
 
 KAS_EXTRA_BITBAKE_ARGS=0
@@ -494,17 +465,17 @@ KAS_FILES=
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
@@ -551,7 +522,7 @@ if [ "${KAS_CMD}" = "menu" ]; then
 
 	# When using the menu plugin, we need to track the KAS_REPO_DIR outside
 	# of the container to later allow a simple `kas-container build`. For
-	# that, we tell the kas menu plugin via an env-var about the location
+	# that, we tell the kas menu command via an env-var about the location
 	# on the host. This data is then added to the .config.yaml where it can
 	# be evaluated by the next invocation of kas-container.
 
@@ -563,10 +534,10 @@ if [ "${KAS_CMD}" = "menu" ]; then
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
@@ -574,20 +545,60 @@ else
 
 	# We only get the first build system and let kas check if mixed
 	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
-	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
-		sed 's/build_system:[ ]\+//')
+	BUILD_SYSTEM=${BUILD_SYSTEM:-$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null |
+		sed 's/build_system:[ ]\+//')}
+fi
+
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
 fi
 
-if [ "${BUILD_SYSTEM}" = "isar" ]; then
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
 
@@ -628,10 +639,21 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
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
@@ -675,6 +697,14 @@ if [ -n "${AWS_WEB_IDENTITY_TOKEN_FILE}" ] ; then
 		-e AWS_ROLE_ARN="${AWS_ROLE_ARN}"
 fi
 
+if [ -n "${KAS_KVM}" ]; then
+	if [ -c /dev/kvm ]; then
+		set -- "$@" --device=/dev/kvm
+	else
+		warning "--kvm given but /dev/kvm not present on host; skipping"
+	fi
+fi
+
 KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
 
 if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
@@ -685,6 +715,14 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
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
@@ -731,7 +769,8 @@ fi
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
            KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
            GIT_CREDENTIAL_USEHTTPPATH \
-           TZ; do
+           BB_HASHSERVE BB_HASHSERVE_UPSTREAM \
+           NO_COLOR TZ; do
 	if [ -n "$(eval echo \$${var})" ]; then
 		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
 	fi
@@ -739,7 +778,7 @@ done
 
 # propagate only supported SHELL settings
 case "$SHELL" in
-/bin/sh|/bin/bash|/bin/dash)
+/bin/sh | /bin/bash | /bin/dash)
 	set -- "$@" -e "SHELL=$SHELL"
 	;;
 *)
@@ -757,7 +796,7 @@ fi
 
 # SC2086: Double quote to prevent globbing and word splitting.
 # shellcheck disable=2086
-set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
+set -- "$@" ${KAS_ISAR_ARGS} ${KAS_RUNTIME_ARGS} ${KAS_EXTRA_RUNTIME_ARGS} \
     ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
 if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
 	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
-- 
2.47.3


