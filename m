Return-Path: <SRS0=7gdN=FF=lists.cip-project.org=bounce+64572+5931+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F1EC64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 16:33:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AC820644
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 16:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="al4VA/Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AC820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5931+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bdfQYY4521723xvXeey7bPfg; Tue, 01 Dec 2020 08:33:37 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.12739.1606840415889698842
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 08:33:36 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0B1GXXqg015392
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Dec 2020 17:33:33 +0100
X-Received: from [167.87.33.175] ([167.87.33.175])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0B1GXWl1023632;
	Tue, 1 Dec 2020 17:33:32 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ebg-secure-boot-secrets: Fix broken SRC_URI
To: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
        cip-dev@lists.cip-project.org, Quirin.Gylstorff@siemens.com
References: <20201201074947.24702-1-Vijaikumar_Kanagarajan@mentor.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <42bd6094-a1bb-cddf-584b-c3f35721fb05@siemens.com>
Date: Tue, 1 Dec 2020 17:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201074947.24702-1-Vijaikumar_Kanagarajan@mentor.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dgEIiQdJWgc6Y9BUO6IDJpnGx4520388AA=
Content-Type: multipart/mixed; boundary="fe8VMh1OKcAEk8WN09ZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606840417;
 bh=5SF8GiiOCx9WzOCINLN44Xj18nwoLzDMdrI6QOtuKis=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=al4VA/FsQ0pOR2GNMxTfSCh6HATurZN4mKNbpOa+8hF4+2+Sr0GmnxU3IlfVT92ypKB
 2wyCkGkJJuGM5BOtRWcRA0eckMK2kmF5BUlJoEh+MkJQ9QTL3eYciZDNRh5I21OLu3DzH
 JTKZEpZ1eyTV4xqgGmmjq4rK9gAfbdjrmuw=

--fe8VMh1OKcAEk8WN09ZR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 01.12.20 08:49, Vijai Kumar K wrote:
> As per documentation, we need to copy the db and cert
> to recipes-devtools/ebg-secure-boot-secrets/files.
> 
> SRC_URI expects file:// prefix for local files. Add that.
> 
> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
> ---
>  .../ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
> index 37b35c9..0d57910 100644
> --- a/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
> +++ b/recipes-devtools/ebg-secure-boot-secrets/ebg-secure-boot-secrets_0.1.bb
> @@ -29,8 +29,8 @@ DEBIAN_CONFLICTS = "ebg-secure-boot-snakeoil"
>  SRC_URI = " \
>      file://sign_secure_image.sh.tmpl \
>      file://control.tmpl"
> -SRC_URI_append = " ${@ d.getVar(SB_CERTDB) or "" }"
> -SRC_URI_append = " ${@ d.getVar(SB_VERIFY_CERT) or "" }"
> +SRC_URI_append = " ${@ "file://"+d.getVar('SB_CERTDB') if d.getVar('SB_CERTDB') else '' }"
> +SRC_URI_append = " ${@ "file://"+d.getVar('SB_VERIFY_CERT') if d.getVar('SB_VERIFY_CERT') else '' }"
>  TEMPLATE_FILES = "sign_secure_image.sh.tmpl"
>  TEMPLATE_VARS += "SB_CERT_PATH SB_CERTDB SB_VERIFY_CERT SB_KEY_NAME"
>  
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--fe8VMh1OKcAEk8WN09ZR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5931): https://lists.cip-project.org/g/cip-dev/message=
/5931
Mute This Topic: https://lists.cip-project.org/mt/78629989/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fe8VMh1OKcAEk8WN09ZR--
