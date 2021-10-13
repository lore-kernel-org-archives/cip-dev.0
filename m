Return-Path: <SRS0=tpoI=PB=lists.cip-project.org=bounce+64572+6820+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41099C433EF
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 14:02:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03E960E8B
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 14:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E03E960E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EtGVYY4521723xTMlmXs4OEG; Wed, 13 Oct 2021 07:02:47 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.8666.1634133766482490456
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 07:02:47 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DE2hrj030261
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 16:02:44 +0200
X-Received: from [167.87.2.42] ([167.87.2.42])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DE2hFc028091;
	Wed, 13 Oct 2021 16:02:43 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: Move handler to own recipe
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
 <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
 <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
 <34ab1f03-a798-8d7d-c616-496846c69e56@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <5cdd639d-93df-4e07-4302-9e41e391f8c0@siemens.com>
Date: Wed, 13 Oct 2021 16:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <34ab1f03-a798-8d7d-c616-496846c69e56@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VZxKiy5jCFIJIZR2Gl1UGivjx4520388AA=
Content-Type: multipart/mixed; boundary="bQAA2cHDXnmCkj1lh9wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634133767;
 bh=73SGoiItcEtBVBSr7ljKVYpNF4wrvps9OUsNpIHjDAM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PHpqL77qsHPzkvoo8EkwvZr1HSqGJBywfCvyt6Buft5+Yh7ioLzO/loJ+FSLoZPGds5
 R7ZjkQluJ/kVq2z6HO+MAG9suIvjfgg6KXiG5NzlgHiANQWABQYO+LfvIUvrOLkp04WsV
 hQ3Mp6DbQxwGEPWlHhlt9e8PH8i0vSYTxfc=
Message-ID: <20211013140243.EBDahwEqufilmJtQYl-1CEWZLy-gb23ZsClAjTTm98o@z>

--bQAA2cHDXnmCkj1lh9wq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 13.10.21 16:01, Gylstorff Quirin wrote:
> 
> 
> On 10/13/21 3:47 PM, Jan Kiszka wrote:
>> Plural or singular? Can a generic swupdate-handler package container
>> multiple handlers? Or will it only ever provide a single handler? In the
>> latter case, make this "swupdate-handler" as well.
> 
> An handler package could contain multiple handlers. Currently we have
> only swupdate-handler-roundrobin.
> 

Ok, thanks for clarifying.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--bQAA2cHDXnmCkj1lh9wq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6820): https://lists.cip-project.org/g/cip-dev/message/=
6820
Mute This Topic: https://lists.cip-project.org/mt/86287949/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bQAA2cHDXnmCkj1lh9wq--
