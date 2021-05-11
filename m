Return-Path: <SRS0=XDV3=KG=lists.cip-project.org=bounce+64572+6448+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F1AC433B4
	for <cip-dev@archiver.kernel.org>; Tue, 11 May 2021 13:50:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2191613AF
	for <cip-dev@archiver.kernel.org>; Tue, 11 May 2021 13:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2191613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6448+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zlRYYY4521723xLlTTMLA7cH; Tue, 11 May 2021 06:50:23 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.13141.1620741021778634764
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 May 2021 06:50:22 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14BDoJ1H000961
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 May 2021 15:50:19 +0200
X-Received: from [167.87.32.54] ([167.87.32.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14BDUvLH031025;
	Tue, 11 May 2021 15:30:58 +0200
Subject: Re: [cip-dev] [isar-cip-core][Resend PATCH 1/4] scripts/deploy-cip-core.sh: Fix uploading tar.gz image
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210510014011.66494-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <b391a367-a2b6-8e62-a8d1-8a1fffb1395f@siemens.com>
Date: Tue, 11 May 2021 15:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510014011.66494-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1C23rBxs0mpXwLfKT67aZVwbx4520388AA=
Content-Type: multipart/mixed; boundary="p0lg8UodBYI2UCqjRMyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620741023;
 bh=uvsBRo0VeA+oBgbuw3e/SkVHUlomQYgP/Fzewbqttgw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=v2yRkzIh52EtSq1g2OBaQv4sU8Zhz0Xjn5ZxrWReUetoerCSKS4UT/PBmAQ/PE7MCMH
 p1lgRejEMUCoekJZdhy19z1zU7pyFrMVNJUBVDuChtpwvPhSHOtQ3vZxivp8y5t5Kf4a7
 dbx9XJEnVx0+cer8dClcNPZ/qYar0qQA6oE=

--p0lg8UodBYI2UCqjRMyX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10.05.21 03:40, Nobuhiro Iwamatsu wrote:
> Since *.wic.img is always compressed, if this file does not exist (for
> example, the extension is tar.gz), the image file upload will fail.
> This will check for the extension of the file.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  scripts/deploy-cip-core.sh | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 5b7eab9..3593d51 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -24,14 +24,17 @@ if [ "${EXTENSION}" != "base" ] ; then
>  	BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
>  fi
>  
> -echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
> -xz -9 -k $BASE_PATH.wic.img
> +if [ -f $BASE_PATH.wic.img ] ; then
> +	echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
> +	xz -9 -k $BASE_PATH.wic.img
>  
> -echo "Uploading artifacts..."
> -aws s3 cp --no-progress $BASE_PATH.wic.img.xz s3://download.cip-project.org/cip-core/$TARGET/
> +	echo "Uploading artifacts..."
> +	aws s3 cp --no-progress $BASE_PATH.wic.img.xz s3://download.cip-project.org/cip-core/$TARGET/
> +fi
>  
>  if [ -f $BASE_PATH.tar.gz ]; then
> -    aws s3 cp --no-progress $BASE_PATH.tar.gz s3://download.cip-project.org/cip-core/$TARGET/
> +	echo "Uploading artifacts..."
> +	aws s3 cp --no-progress $BASE_PATH.tar.gz s3://download.cip-project.org/cip-core/$TARGET/
>  fi
>  
>  KERNEL_IMAGE=$BASE_PATH-vmlinuz
> 
> 

Thanks, all 4 applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--p0lg8UodBYI2UCqjRMyX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6448): https://lists.cip-project.org/g/cip-dev/message=
/6448
Mute This Topic: https://lists.cip-project.org/mt/82710800/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--p0lg8UodBYI2UCqjRMyX--
