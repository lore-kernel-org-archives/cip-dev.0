Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B562C44509
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90782.1783076373136491246
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Omr3GmQ5;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-461edb387ddso494811f8f.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076371; x=1783681171; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lBX9NxnwcSwFeFcsx/fnMCRLMF3a6BgXJ83E/ohjr4=;
        b=Omr3GmQ5u6/KvEouqqaW1WytrjBtnx9oZQ/zknHInxOEXfTWEtd975Bu18fj8CgGlR
         hWN2y2tSA2me7cyWdXknxBS2WJJ5tZRHv2EW1IblH+v3XkcYykLp2XeUWAYs/2ueIBYt
         VPD3Ud1sQNMiZIptDMPqlXwSS4dEH+2lTgrSIJ/0xV2yqKAoamhJPCZ1CJTd256OL8+p
         /iJVL5oxIEbIW+GYKWE+DnoUfRAWKw6TVuk//e9I3H1O8wbY936qK1EGuktMVbENuD2Z
         QEn1jYpilmtHUk8QLrkoHgDjv9GZrWi2z7bN6ecW0oJSA8SaJFD88APZcVn7Q3g0lCZs
         NpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076371; x=1783681171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lBX9NxnwcSwFeFcsx/fnMCRLMF3a6BgXJ83E/ohjr4=;
        b=Kr42TjuzDtY/vCDVrn0pWUeXhTD3myKP6jldXk/KVUz5BNAaCyKv0NZs6N1cTw9KmF
         r/96sve9ojEXBU/XvRdNExuEYxzF5eXN6CZdcC4nqJgbwPnLqDzMx8eIaSSnnJ/DRLXS
         obhnrNDPipx+eqj9gJaLjzVjYC3HfiyJe0Hxjnv4CmahfnPi6Sh6PHljHMgow/YSf7Px
         /gD90Mz7UQfKqUwZ1D9PJ167d1/AsnHC8YRnaE0Q9pg21Yf/vlORsrjHB3d2al0KSrgL
         GDoUlDRfDV/FDwgkKRkaKomTVhhEEpVFZeaCXYPmN29hIWX9mxd+ck3xmPetXkS4szsE
         YmTA==
X-Gm-Message-State: AOJu0YyRqFHCLlVDa9cC5zThtgkYktbctH/rw8vF1a/Q83SGCqKAGKx9
	h4ZC26szxQAyPEDZfUIDVkJy6nbIDIaHAYlaR2BOylxIWCuOh2zUKEJ1qfB5GT8f
X-Gm-Gg: AfdE7cmbNbjV0IYuO7saMIFkG378zNkN+0iZ8AcGSC87yb95z/UKCJeqkKZTnE8mMGc
	eTDVpxA1BFsGlxo5ehhXJBeeI6BpjiTwOa8gUDrYyYZ1FIE+uMeLNhx+xWP5S4xquWhcOZb/uxn
	oulZK7qtVRGE7BxZbx7XKg/mRqi+NcUrVMJa1AmjgkrnNJSPraiu4Wx/T6QbHYUwOdIRpfJSJhp
	cknIzpc2qw27jzu8CrR27jkOw+ZZZ3koGeHMTeA1Z4LfI09rJC00L8gz3rI52XD51yP27VL564/
	uRW+kAtztAzQyi1YadlNYFYxC1uK/fbrUMWxrFemgGLZGiyFGP3oghR5ZEP2flPmvKH4SCrwkhE
	kS0bk+MlL9dofhSX39cn9/8fRElyBG+8rXLOFRiBf8R1HL6V424XTcETCcvSSv49pYI3s1FQAek
	Uw3+2DHDNFBPfpbepQvNIc
X-Received: by 2002:a05:6000:1448:b0:476:bcd3:f620 with SMTP id ffacd0b85a97d-477af12028dmr14018221f8f.14.1783076371221;
        Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/23] mfd: syscon: Allow syscon nodes without a "syscon" compatible
Date: Fri,  3 Jul 2026 11:59:05 +0100
Message-ID: <20260703105923.251255-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23433

From: "Rob Herring (Arm)" <robh@kernel.org>

[ Upstream commit ba5095ebbc7a83965ac049a50fa493d7c751f19b ]

of_syscon_register_regmap() was added for nodes which need a custom
regmap setup. It's not really correct for those nodes to claim they are
compatible with "syscon" as the default handling likely doesn't work in
those cases. If device_node_get_regmap() happens to be called first,
then of_syscon_register() will be called and an incorrect regmap will be
created (barring some other error). That may lead to unknown results in
the worst case. In the best case, of_syscon_register_regmap() will fail
with -EEXIST. This problem remains unless these cases drop "syscon" (an
ABI issue) or we exclude them using their specific compatible. ATM,
there is only one user: "google,gs101-pmu"

There are also cases of adding "syscon" compatible to existing nodes
after the fact in order to register the syscon. That presents a
potential DT ABI problem. Instead, if there's a kernel change needing a
syscon for a node, then it should be possible to allow the kernel to
register a syscon without a DT change. That's only possible by using
of_syscon_register_regmap() currently, but in the future we may want to
support a match list for cases which don't need a custom regmap.

With this change, the lookup functions will succeed for any node
registered by of_syscon_register_regmap() regardless of whether the node
compatible contains "syscon".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241217-syscon-fixes-v2-3-4f56d750541d@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/syscon.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 729e79e1be49..4346eeab4053 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -176,9 +176,12 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	if (!syscon)
-		syscon = of_syscon_register(np, check_res);
-
+	if (!syscon) {
+		if (of_device_is_compatible(np, "syscon"))
+			syscon = of_syscon_register(np, check_res);
+		else
+			syscon = ERR_PTR(-EINVAL);
+	}
 	mutex_unlock(&syscon_list_lock);
 
 	if (IS_ERR(syscon))
@@ -243,9 +246,6 @@ EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
-	if (!of_device_is_compatible(np, "syscon"))
-		return ERR_PTR(-EINVAL);
-
 	return device_node_get_regmap(np, true);
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
-- 
2.43.0


