Return-Path: <SRS0=tWw0=FS=lists.cip-project.org=bounce+64572+5959+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F52C4361B
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 07:45:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C792D225AC
	for <cip-dev@archiver.kernel.org>; Mon, 14 Dec 2020 07:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C792D225AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5959+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K9W2YY4521723xbODgumT9XJ; Sun, 13 Dec 2020 23:45:19 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.31640.1607931917855368958
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Dec 2020 23:45:18 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BE7jGSB018993
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 14 Dec 2020 08:45:16 +0100
X-Received: from [167.87.38.225] ([167.87.38.225])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BE7jFxt014372;
	Mon, 14 Dec 2020 08:45:16 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] add pycache to .gitignore
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20201211135448.17147-1-Quirin.Gylstorff@siemens.com>
 <20201211135448.17147-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <f9422fc8-4404-0032-4eb3-43c228ca1892@siemens.com>
Date: Mon, 14 Dec 2020 08:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201211135448.17147-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kexPM9qdEh9FCzBlDORKbBVdx4520388AA=
Content-Type: multipart/mixed; boundary="bx9jXCOfQjftrz3sF6FA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607931920;
 bh=kmbtx+DUZMxeKDFx3vk4O4KAYJ0himT/o5fuEw4U0O4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kUT9a9OWFAKNfueMjwD7RP/9CozhScL+ahOaqVn7OcSNLYmMyfl0dLVrMjgpTb0qWqa
 1FuwwQCnoq8dsVR1SbEwZtsuO8Uz7QSbD9U/N0l4L9/DpZcHOLBOO6rXbUqiQs8MpCytY
 zkTxB03HUCdn/arebuA/vipeITAy6BNy30s=

--bx9jXCOfQjftrz3sF6FA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 11.12.20 14:54, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If a project derives from isar-cip-core and needs to patch isar-cip-core
> the patching fails after a build as the repository is dirty. Fix by
> ignoring the pycache directory.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 5142933..b73840f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,3 +2,4 @@ build/
>  isar/
>  kas-docker
>  kas-container
> +__pycache__
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--bx9jXCOfQjftrz3sF6FA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5959): https://lists.cip-project.org/g/cip-dev/message=
/5959
Mute This Topic: https://lists.cip-project.org/mt/78879162/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bx9jXCOfQjftrz3sF6FA--
