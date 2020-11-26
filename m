Return-Path: <SRS0=hB9k=FA=lists.cip-project.org=bounce+64572+5881+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D334C56202
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 07:29:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B5E2173E
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 07:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="U2FB0M4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B5E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5881+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wFo1YY4521723x0JLzRDvzeS; Wed, 25 Nov 2020 23:28:59 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.2022.1606375737981214395
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 23:28:58 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AQ7Stqg021304
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2020 08:28:55 +0100
X-Received: from [167.87.38.29] ([167.87.38.29])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AQ7SstP000432;
	Thu, 26 Nov 2020 08:28:55 +0100
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] classes/image_uuid: Generate new uuid if a new package is added
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <c02e7a38-5bc1-7e4a-61fe-77cce775acab@siemens.com>
 <20201125084433.1277-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <38bc77ba-9cb4-55e9-2718-d26bc067874f@siemens.com>
Date: Thu, 26 Nov 2020 08:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125084433.1277-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 81YewxsPbbOz7EEADYGvEdSUx4520388AA=
Content-Type: multipart/mixed; boundary="IgW3hNN2U6bKrpqBaWEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606375739;
 bh=9v7bg4x8YXPQ5gX3CNu/TYuN8NGDayQ/pDnEfvYrFvQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=U2FB0M4XeFs6FhDVbDALxeqO/pzCCS6IFXwDfrNaQrgFoAJima9VMgj9JAUesFWKohW
 o74sbA+jm5EKa1J9bvbTLTRLfMtylkvbpK85b/64n4t3cqOA3Pzl9oMjzXEwXdL3SEfoH
 OrTeC1jutktOy/QOx482n16c+WdHqGr9Q2w=

--IgW3hNN2U6bKrpqBaWEP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 25.11.20 09:44, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> BB_BASEHASH only includes the task itself and its metadata.
> Dependencies are not taken into account when this hash is
> generated which means updating a package will not generate a new
> UUID.
> 
> BB_TASKHASH takes the changes into account.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/image_uuid.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index d5337b8..2813ed9 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -12,7 +12,7 @@
>  def generate_image_uuid(d):
>      import uuid
>  
> -    base_hash = d.getVar("BB_BASEHASH_task-do_rootfs_install", True)
> +    base_hash = d.getVar("BB_TASKHASH", True)
>      if base_hash is None:
>          return None
>      return str(uuid.UUID(base_hash[:32], version=4))
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--IgW3hNN2U6bKrpqBaWEP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5881): https://lists.cip-project.org/g/cip-dev/message=
/5881
Mute This Topic: https://lists.cip-project.org/mt/78496128/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--IgW3hNN2U6bKrpqBaWEP--
