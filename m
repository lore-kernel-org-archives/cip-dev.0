Return-Path: <SRS0=2G4g=LM=lists.cip-project.org=bounce+64572+6538+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0FC48BDF
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:42:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8BC61159
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8BC61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6538+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8xXFYY4521723xvs69UIgf9x; Fri, 18 Jun 2021 06:42:19 -0700
X-Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web12.8105.1624023738628246768
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 06:42:19 -0700
X-Received: by mail-lf1-f51.google.com with SMTP id bp38so16898645lfb.0
        for <cip-dev@lists.cip-project.org>; Fri, 18 Jun 2021 06:42:18 -0700 (PDT)
X-Gm-Message-State: L8wRY8sIV5vCBZIBBnkxZr8xx4520388AA=
X-Google-Smtp-Source: ABdhPJwlYFe3ZxR6iktzVDRXhBO8+T9ovag/LQZfQ3qanE/BH1Ajjkl+0duIdZQ6DCa04rWPXLtq/xMaB2F9aGC0qQw=
X-Received: by 2002:ac2:5ec9:: with SMTP id d9mr3217262lfq.132.1624023736477;
 Fri, 18 Jun 2021 06:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
In-Reply-To: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
From: "Srinuvasan Arjunan" <srinuvasanasv@gmail.com>
Date: Fri, 18 Jun 2021 19:12:02 +0530
Message-ID: <CAB2Z2nPvbnsNBNx_xKuJXdJK=9ZaaJtdX64nRxN4sD35kxpYgw@mail.gmail.com>
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
To: cip-dev@lists.cip-project.org
Cc: Srinuvasan A <Srinuvasan_A@mentor.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="WtGcgSiCSGC6nXrvbnGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624023739;
 bh=vvvUseVQ1dkQtEZfbiiaVhcOnZysmSvVpusagV5byxI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=INO1YMOkD6GTmmL06mlqc0tM0qJEybC0vXEO8l00hx4GgYNp2vEHKAgBuoI3l5wRpzg
 IIHhHvjs088xc1rIGfVoddH8UqykMulrD6B6N6NefP3mtJX8Blw+pE+TvPDTtJgJKRcwy
 DJOBrTiSQtsAzRWrYK+3A7kw4kvmtMjd90Y=

--WtGcgSiCSGC6nXrvbnGI
Content-Type: multipart/alternative; boundary="000000000000eb69ca05c50a7d3d"

--000000000000eb69ca05c50a7d3d
Content-Type: text/plain; charset="UTF-8"

Hi pavel,

    Did uprev for cip-kernel-config, this need to be merge .

Thanks,
Srinuvasan.A

On Tue, 15 Jun, 2021, 10:50 am Srinuvasan A, <srinuvasan_a@mentor.com>
wrote:

> Bump the cip-kernel-config revision for brings the User and Sync
> kselftest.
>
> Signed-off-by: Srinuvasan A <Srinuvasan_A@mentor.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-kernel/linux/linux-cip-common.inc
> b/recipes-kernel/linux/linux-cip-common.inc
> index 021efcd..6362408 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://
> gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>
>  SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>
> -SRCREV_cip-kernel-config ?= "9fa9154c77ee8eeca534aa436c23582c0c59c39f"
> +SRCREV_cip-kernel-config ?= "b72318b9346f7262f6dd7511384ca61bd8b545c8"
>
>  S = "${WORKDIR}/linux-cip-v${PV}"
> --
> 2.25.1
>
>
> 
>
>

--000000000000eb69ca05c50a7d3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi pavel,<div dir=3D"auto"><br></div><div dir=3D"auto">=
=C2=A0 =C2=A0 Did uprev for cip-kernel-config, this need to be merge .</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"au=
to">Srinuvasan.A</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, 15 Jun, 2021, 10:50 am Srinuvasan A, &lt;<a h=
ref=3D"mailto:srinuvasan_a@mentor.com">srinuvasan_a@mentor.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Bump the cip-kernel-config revis=
ion for brings the User and Sync<br>
kselftest.<br>
<br>
Signed-off-by: Srinuvasan A &lt;<a href=3D"mailto:Srinuvasan_A@mentor.com"=
 target=3D"_blank" rel=3D"noreferrer">Srinuvasan_A@mentor.com</a>&gt;<br>
---<br>
=C2=A0recipes-kernel/linux/linux-cip-common.inc | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/li=
nux/linux-cip-common.inc<br>
index 021efcd..6362408 100644<br>
--- a/recipes-kernel/linux/linux-cip-common.inc<br>
+++ b/recipes-kernel/linux/linux-cip-common.inc<br>
@@ -25,6 +25,6 @@ SRC_URI_append =3D &quot; ${@ &quot;git://<a href=3D"htt=
p://gitlab.com/cip-project/cip-kernel/cip-kernel-confi" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">gitlab.com/cip-project/cip-kernel/cip-kernel-c=
onfi</a><br>
<br>
=C2=A0SRC_URI_append_bbb =3D &quot;file://${KERNEL_DEFCONFIG}&quot;<br>
<br>
-SRCREV_cip-kernel-config ?=3D &quot;9fa9154c77ee8eeca534aa436c23582c0c59c=
39f&quot;<br>
+SRCREV_cip-kernel-config ?=3D &quot;b72318b9346f7262f6dd7511384ca61bd8b54=
5c8&quot;<br>
<br>
=C2=A0S =3D &quot;${WORKDIR}/linux-cip-v${PV}&quot;<br>
-- <br>
2.25.1<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000eb69ca05c50a7d3d--

--WtGcgSiCSGC6nXrvbnGI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6538): https://lists.cip-project.org/g/cip-dev/message=
/6538
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WtGcgSiCSGC6nXrvbnGI--
