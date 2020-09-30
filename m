Return-Path: <SRS0=71uA=DL=lists.cip-project.org=bounce+64572+5496+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E584C4363C
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 14:58:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE26206A1
	for <cip-dev@archiver.kernel.org>; Sun,  4 Oct 2020 14:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dgzrgBZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE26206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5496+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id b8K2YY4521723xUS05UqFIxM; Sun, 04 Oct 2020 07:58:56 -0700
X-Received: from mout.web.de (mout.web.de [212.227.15.14])
 by mx.groups.io with SMTP id smtpd.web12.9874.1601449907908578597
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 00:11:48 -0700
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
X-Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8ai-1k1bhh3P4C-00MEW6; Wed, 30
 Sep 2020 09:11:45 +0200
Subject: Re: [cip-dev] [isar-cip-core] image: export dpkg status file for debsecan
To: cip-dev@lists.cip-project.org,
 Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
References: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
 <20200930020815.2474349-2-daniel.sangorrin@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <7596cf39-b8f9-cedc-3b51-b164553b3ee4@web.de>
Date: Wed, 30 Sep 2020 09:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930020815.2474349-2-daniel.sangorrin@toshiba.co.jp>
X-Provags-ID: V03:K1:wfPz2rW68EDF+iX9vULRwdq9M7w6ynwgt/wfHrh4DViF2yE5lbh
 +LVyZ3QJrqd3O5pkQYS1b7iaoqaUrKqFsmLzSDCe8KNzIIGsuc9y4mox3qSddlLR5ICO5Zs
 ++VV2GGlkwRTSpe69MFZLYCn87Zyz3D9oIEl6HXXHNSvXM9AGjRSN1LTZbFIPm+pu18ntEi
 suaYYj0SgA9r2h2QXEIWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pAYRagH0ckw=:ksPr6wcMcRwkD4oBwNtnPo
 PClg6tcgJGCIu6cCfncGavkbZ6jx8Wrl695OZFI1uqERwAhfMwK7SQ16UjvWhNDRwa8vkO5S7
 ikeXN7o6/tS7nmsmb1KkjFKXcSAWJI0cBFKAoz7NpWfvPAbiXe1Gv01jATKAqjDdPzprGo+nf
 +qjMzxbrhCk6xVjK2K3LUZQ2VDdAELAovv19KX+Efko3Ov9FFU3EN0vd0AZg9CuXS/n2gPsXF
 gZTlWHo6dHXA2E0f2lfv7IXfiUaS/Wr9n94+s+f4bUYOXDktIOZRuVtQOToh0pZ07LpKp+Ocf
 N7qto+ZMfWc9MbgkE7AzzgdmVNmfJYy+5ZmanZMKK2C6bxMCeE6xewAr3X6LiqMQHSMPN7QBc
 rlcwgS4cHBR+zszpU+G0WYV/UED3VsBxffOT2u4CCt2jpPJCLrLrpXjx6CUY4YuxYnrV5wKXj
 QXrucvSK+wFRvtLtO+8S8hA5W6wIC1Q3Je5ut9QF8xy8Hd6glELxiQSX0ut+ke9BMk1/selMl
 PKozdZ1/pS9TiVQJTY3LJ+eLBgjAXdv00DM6OyjJo6ocXPE5NOCJ6oh7FgL8Fhl6Avc8i0vlu
 2A5O0kTFooFpNzfWTpRiYpuW6Hc7WI8LJi+lPaeuy/GCB+KBQ4WMd6ob0X+SuVaQeu3Ty7pcZ
 na9BzdOb5YmWioBt1QFmwuEg56KEnYWtiYOlkyYPHW5hJacDX+U3AOBVnw1T/aE8T5yJE9Bww
 uMAA+Iy63TSzo16NHkP1vD/fJQk+ntkfL/+mS6w5oMwcpGxhEttlgr7YjK65bfnAfSK7lIaUT
 j2eLaJX8uuzMiSOHNE0nNO67SRCuV/K/jwA1BIqxX/IOGEgt/3mt11rBiOKbYk+GOXfPJmIGJ
 9FyKspnjKUYUDK/2pEiB76362EN9t78iK5Ubu4WfML4ty+yr+OS5HE1IyKEn+opB5BuaEWJ9U
 Oy4EZq85fCGb4Ud+oY7APwoRZJ4wZZBdd15UxsAUlt27u5HiFHnQvcfvTv8TmG9L0FJiQq73Z
 2mp5faU2xL/TE/U29vm77XL/2KMye8vLXcayBWX5MxLtDgiP4fw+m0nf2JPhb7dEM7NaassEq
 Mfxv6DziV//wc9T0oR/vCgeHr6VKUL9kabPL1I35m4AuRqyj5545aO9agboGf/bCN67Q1Vh6b
 2ZeVHvQ4Gkt1x6gkajmT4Qn1/3Zvu60YKlmcF9IQEOOwtnxwpAjySBmbU7OG61XuAJjgdPH2W
 V8NiAwhBmuHmz8zQ0hFOAnMUTlIrh+uIZpUmySg==
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WugXC78KJaSWqngmVszq4S7Vx4520388AA=
Content-Type: multipart/mixed; boundary="PRDE5nQcThVtoUuUHnPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601823536;
 bh=mcaoPkPMzio0yGFq0TBX1UBC73ZAXI1dDw5Q0TNYhuY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dgzrgBZBxlHuCffyc8y5tGFSD6ByNAtZ8fmZcad9gTYztb2RHmpa1V0C6se9E9xCIbI
 Q/HDQhFZeVWOHN4P+SzbkxQaneBiYdk1YonNdvoQulehAklhxtCzPcggbtiledXdL/jE3
 57Rfu+j3xOInTEHH15V/vYeuGFKD+9LQF7c=

--PRDE5nQcThVtoUuUHnPH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.09.20 04:08, Daniel Sangorrin wrote:
> Although the currently exported manifest probably has
> enough information, the tool debsecan and our wrapper
> cip-core-sec depend on the dpkg status format.
>
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  recipes-core/images/cip-core-image-security.bb | 8 ++++++++
>  recipes-core/images/cip-core-image.bb          | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-co=
re/images/cip-core-image-security.bb
> index 61ddc39..928774c 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -34,3 +34,11 @@ IMAGE_PREINSTALL +=3D " \
>  	uuid-runtime \
>  	sudo \
>  "
> +
> +# for cip-core-sec/debsecan
> +ROOTFS_POSTPROCESS_COMMAND +=3D "export_dpkg_status"
> +export_dpkg_status() {
> +    sudo -E chroot --userspec=3D$(id -u):$(id -g) '${ROOTFSDIR}' \
> +        cat /var/lib/dpkg/status > \
> +        ${ROOTFS_MANIFEST_DEPLOY_DIR}/"${PF}".dpkg_status

This is just a copy-out, I don't see the chroot need here.

> +}
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images=
/cip-core-image.bb
> index 2cecde3..0139819 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -19,3 +19,11 @@ IMAGE_INSTALL +=3D "customizations"
>  # for swupdate
>  SWU_DESCRIPTION ??=3D "swupdate"
>  include ${SWU_DESCRIPTION}.inc
> +
> +# for cip-core-sec/debsecan
> +ROOTFS_POSTPROCESS_COMMAND +=3D "export_dpkg_status"
> +export_dpkg_status() {
> +    sudo -E chroot --userspec=3D$(id -u):$(id -g) '${ROOTFSDIR}' \
> +        cat /var/lib/dpkg/status > \
> +        ${ROOTFS_MANIFEST_DEPLOY_DIR}/"${PF}".dpkg_status
> +}
>

Please avoid code duplication. We have means like "require some.inc" in
bitbake.

I'm also wondering if this should go to isar upstream directly. debsecan
is a generic Debian tool, nothing CIP-specific per se.

Jan

--PRDE5nQcThVtoUuUHnPH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5496): https://lists.cip-project.org/g/cip-dev/message=
/5496
Mute This Topic: https://lists.cip-project.org/mt/77210404/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PRDE5nQcThVtoUuUHnPH--
