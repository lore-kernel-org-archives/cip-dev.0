Return-Path: <SRS0=dNoR=GQ=lists.cip-project.org=bounce+64572+6063+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280DC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 10:46:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B935423102
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 10:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B935423102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6063+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f6HqYY4521723xZBcpLYVIb1; Wed, 13 Jan 2021 02:46:09 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.6368.1610534768154295972
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 02:46:08 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 10DAk4MM022913
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Jan 2021 11:46:05 +0100
X-Received: from [167.87.43.185] ([167.87.43.185])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10DAk3gM017839;
	Wed, 13 Jan 2021 11:46:04 +0100
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
To: cip-dev@lists.cip-project.org, Henning Schild <henning.schild@siemens.com>
Cc: Claudius Heine <ch@denx.de>
References: <20210111154856.6636-1-henning.schild@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
Date: Wed, 13 Jan 2021 11:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111154856.6636-1-henning.schild@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ggsoiYyTg3EwIMZiZTWvj2rDx4520388AA=
Content-Type: multipart/mixed; boundary="T2GQfvujcABELWI2LEW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610534769;
 bh=uHrPCjB9vqWl10t15WzClQ+HmKcG9g6YjgyhTvVhHRg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sYgMQtwFtQFwprykz2YvzsG3ALNLReCcQuLg9arycDl2RPnz0bADYd+66LeKxCc5PNT
 beFtm6o2LQM7RZ91w9YAp5btkvs+odGItUolyoDC6NjUUfHhprL7Ftou0lJwSiGllo+08
 FTVSHdmYHkTityR5CO3s5MkgTLjNs5wzRqQ=

--T2GQfvujcABELWI2LEW8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 11.01.21 16:48, Henning Schild wrote:
> From: Claudius Heine <ch@denx.de>
> 

Can you also provide a reasoning here?

> Signed-off-by: Claudius Heine <ch@denx.de>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  classes/swupdate-img.bbclass | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
> index a21d6ec..a7a70f6 100644
> --- a/classes/swupdate-img.bbclass
> +++ b/classes/swupdate-img.bbclass
> @@ -39,14 +39,14 @@ do_swupdate_image() {
>          image_do_mounts
>          cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
>          test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
> -
> -        # Fill in file check sums
> -        for file in ${SWU_ADDITIONAL_FILES}; do
> -            sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
> -                '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
> -        done
>      fi
>  
> +    # Fill in file check sums
> +    for file in ${SWU_ADDITIONAL_FILES}; do
> +        sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
> +            '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
> +    done
> +
>      cd "${WORKDIR}/swu"
>      for file in '${SWU_DESCRIPTION_FILE}' ${SWU_ADDITIONAL_FILES}; do
>          echo "$file"
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--T2GQfvujcABELWI2LEW8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6063): https://lists.cip-project.org/g/cip-dev/message=
/6063
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--T2GQfvujcABELWI2LEW8--
