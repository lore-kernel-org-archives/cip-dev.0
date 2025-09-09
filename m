Return-Path: <d.kauschke154@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0491CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 13:01:03 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web10.12384.1757422863009543960
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Sep 2025 06:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@googlemail.com header.s=20230601 header.b=I3iz08WH;
 spf=pass (domain: googlemail.com, ip: 209.85.218.41, mailfrom: d.kauschke154@googlemail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b046fc9f359so1004207066b.0
        for <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757422861; x=1758027661; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5LinUPqxGX/pbLlxP78/Lc90RXK/8xj1nKVXtgiML8=;
        b=I3iz08WHRcr6vcP2n//4dE+0yixBUMh9sAfMDhNglVG+1CDpwinxw7nPGa54UBoZUn
         4F92WowHuq6QcdtZkIbTkGJ4vmYkY07UKM/jvsrsG40BbZXhrXSA1LiqbbO86s1CgOIi
         pMC/ZCKcSyJNssTwW0WYBczawCy86CI1q1D7QxXdaHSq83lIUMXVXcnpzRx9FolN+Cj/
         w/Bb3ciVsl/bh9KFrXYp0K4l65HQh7fdGlECvBsecmm1yfevpBsNebcYWHL7Ee8gvUSH
         YreKM7ScAjIstnDeSlejUWcgkbEMW3fhA41WDYKkKHTZ805wvmLH8bkJnIiF4xFBRmoA
         w0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422861; x=1758027661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5LinUPqxGX/pbLlxP78/Lc90RXK/8xj1nKVXtgiML8=;
        b=e3sK8lK9kqNhlcBABg+/++j78HbK99lKAJH1PMOqbKDrxQHvXuN+66EVqaz8QmW0h7
         oTsxvY0enwHTA90+Uc4xgos9c8tH0p+epw3sR+6tBBelo5/WP53GkUgbMf7F765HGkYK
         jr/6YkuSYT7zzRxAew8wIrBxozD3n9scSML/fOR/4ra/QEpxVW2eq+JLQJ4h0FwweVR/
         /lmkvh1oWYrnqjSx6+0Lv4ueeLX+DGjA1ELd1UnOhZ2P+2xtQwaWWWmmbj958wLzOPPJ
         TRaBDXoVSXLxFAjMFk+xDx1m86I/FOUXowYvGIpD2dJ+uyt7S23dSGI8wqi1xGuuBy4R
         HhCw==
X-Gm-Message-State: AOJu0YwhSidF+q3JaLQOWUZVdMe0J3fVHmWCDNL4eyl0Ha7Tpx95HDQ/
	7GQ7YCET4MQZpxuM77LHCoTuqYAvmxlHPGgqJMgQI3FFs7JHimYE6pc=
X-Gm-Gg: ASbGncveEgSNEQpKrzUKoPTHBDOOrSTeH36+k61gvEyve7BNQK6784LviVvbXYTFLiX
	4HPnKtg1vOR0Vq4f7T2DoP10QGIFfKzYjygBY3f7z1A5E6lqJooiiwQOEcOy0Rb5jMF/hCYKFc+
	tA0R3HTa7rz06YJL3pduhrq2egsUGeE80qXfx2lMZEoI6JCu881m2cwkOsRwsswuFc83OeP6pQB
	ItVFVZcCSdiUMJym+cIDtwf3Kd/u77TDG+vkFV4j7MR44Bacfd/eFYPb0ytKHqMgN1ERBR6Q00Y
	dx1+KcgJJqcC4MzxhCHFsVUXYEVLRqdkVA3vjWzENgHm2VY9PuVxPORGULPC0BPVFiWiSzJXk/0
	KUk2Gmewh9czI5jRpo2A2Gbc20oJ+idzsKcxbS9LIz1SjVBOr1Hsj1QX2hxlSYyxaWlJp14SWMr
	YWvugemSpa+Y22a+mB87RM/zKINTY/H+H4PkImezbG3SGC96sNTJp5DZNNkg==
X-Google-Smtp-Source: AGHT+IFdwY3TmaZRG0y8xV01KHig/eFxxMtCEi6GiIQurawJduPNp79iGZMAxzh1eIcdicxffoULdQ==
X-Received: by 2002:a17:907:7e9f:b0:b04:6bb6:c91d with SMTP id a640c23a62f3a-b04b13c174amr987066666b.1.1757422860993;
        Tue, 09 Sep 2025 06:01:00 -0700 (PDT)
Received: from gag01r377vm006.cen5chzh3mjezjyzbv0znzr1ja.ax.internal.cloudapp.net ([20.56.117.7])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b040f1cf4b9sm2301932466b.29.2025.09.09.06.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:01:00 -0700 (PDT)
From: David Kauschke <d.kauschke154@googlemail.com>
X-Google-Original-From: David Kauschke <david.kauschke.ext@zeiss.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	David Kauschke <david.kauschke.ext@zeiss.com>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: add tpm_tis_spi module support
Date: Tue,  9 Sep 2025 13:00:43 +0000
Message-ID: <20250909130043.145123-1-david.kauschke.ext@zeiss.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Sep 2025 13:01:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20028

The initramfs crypt hook currently loads tpm_tis and tpm_crb but not
tpm_tis_spi. On systems where TPM is connected over SPI, such as with
the Infineon OPTIGA TPM SLB 9672, the absence of this module prevents
TPM initialization during early boot.

Signed-off-by: David Kauschke <david.kauschke.ext@zeiss.com>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 1 +
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 0d42bd4..664124d 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -42,6 +42,7 @@ esac
 
 # load necessary kernel modules:
 modprobe tpm_tis
+modprobe tpm_tis_spi
 modprobe tpm_crb
 
 modprobe ecb
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index e2d55f9..e107575 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -39,7 +39,7 @@ DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
 DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
 
 HOOK_ADD_MODULES = " \
-    tpm tpm_tis_core tpm_tis tpm_crb dm_mod dm_crypt \
+    tpm tpm_tis_core tpm_tis tpm_tis_spi tpm_crb dm_mod dm_crypt \
     ecb aes_generic xts"
 
 HOOK_COPY_EXECS = " \
-- 
2.43.0


