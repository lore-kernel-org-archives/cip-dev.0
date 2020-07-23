Return-Path: <SRS0=JQmF=BC=lists.cip-project.org=bounce+64572+4991+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ABC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 13:52:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A632080D
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 13:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="w2ekb+Md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A632080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4991+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iAP6YY4521723xJCKtTyVgVG; Thu, 23 Jul 2020 06:52:53 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.12732.1595512371036961155
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2020 06:52:52 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 06NDqmAO013380
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2020 15:52:48 +0200
X-Received: from [139.25.68.37] ([139.25.68.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06NDqla7006456;
	Thu, 23 Jul 2020 15:52:47 +0200
Subject: Re: [cip-dev] [PATCH 1/3] cip-security: Add packages for IEC-62443-4-2 Evaluation.
To: cip-dev@lists.cip-project.org,
        Venkata Pyla <venkata.pyla@toshiba-tsip.com>
References: <ab8b6d0d-aff4-cdfe-e926-385f62aae02d@siemens.com>
 <15065.1595510009905529924@lists.cip-project.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <06f7fc59-f004-3d68-d169-0e7d41f33038@siemens.com>
Date: Thu, 23 Jul 2020 15:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15065.1595510009905529924@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fJ8t1bOd2xfn3U07V7axfgPYx4520388AA=
Content-Type: multipart/mixed; boundary="luqFKoHSjKClTR8dWoYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595512373;
 bh=Tcr+rEIfoS482JHBMZ5jgp/AZIbvvpoLTwaxqIrzAYo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=w2ekb+Mdzzb0tAd0TnBMRaNK5vkmOiyxIiWWaEgxUWebV6jjhcp+syb0xK9DeduvDPh
 zSdmwmI0lhBN1gdI+dlQVo10lKFAcVWMNNxHmD/FsBLDxmM30h40PEnLhO8+oDJUDFzxG
 Carys1iBpMaDaHtGJ5rJ4tmIMBHvj4cezcA=

--luqFKoHSjKClTR8dWoYI
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 23.07.20 15:13, Venkata Pyla wrote:
> Hi Jan,
> 
> sorry i am resending this mail
> 
> On Thu, Jul 23, 2020 at 04:07 PM, Jan Kiszka wrote:
> 
>>
>> On 21.07.20 10:16, Venkata Pyla wrote:
>>> From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>>>
>>> Identified security packages are added to the target image
>>> and that will be used for IEC-62443-4-2 evaluation
>>>
>>> Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>>> Signed-off-by: pvenkata2 <venkata.pyla@toshiba-tsip.com>
>>                    ^^^^^^^^^
>> Can you configure your git to add you written name here as well? It's in
>> the email, yes, but it would be nicer to have it displayed as well.
> 
> sure, i didn't notice, it was missed in my git config
> 
>>> ---
>>>    .../images/cip-core-image-security.bb         | 37 +++++++++++++++++++
>>>    1 file changed, 37 insertions(+)
>>>    create mode 100644 recipes-core/images/cip-core-image-security.bb
>>>
>>> diff --git a/recipes-core/images/cip-core-image-security.bb
>> b/recipes-core/images/cip-core-image-security.bb
>>> new file mode 100644
>>> index 0000000..8253952
>>> --- /dev/null
>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>> @@ -0,0 +1,37 @@
>>> +#
>>> +# A reference image which includes security packages
>>> +#
>>> +# Copyright (c) Toshiba Corporation, 2020
>>> +#
>>> +# Authors:
>>> +#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +inherit image
>>> +
>>> +DESCRIPTION = "CIP Core image including security packages"
>>> +
>>> +# Use the same customizations as cip-core-image
>>
>> That comment is not needed. It just creates the risk of becoming
>> outdated if cip-core-image decides to do something else.
>>
> 
> Understood, i will modify and resend this patch series
> 
>>> +IMAGE_INSTALL += "customizations"
>>> +
>>> +# Debian packages that provide security features
>>> +IMAGE_PREINSTALL += " \
>>> +	openssl libssl1.1 \
>>> +	fail2ban \
>>> +	openssh-server openssh-sftp-server openssh-client \
>>> +	syslog-ng-core syslog-ng-mod-journal \
>>> +	aide aide-common \
>>> +	libnftables0 nftables \
>>> +	libpam-pkcs11 \
>>> +	chrony \
>>> +	tpm2-tools \
>>> +	tpm2-abrmd \
>>> +	libtss2-esys0 libtss2-udev \
>>> +	libpam-cracklib \
>>> +	acl \
>>> +	libauparse0 audispd-plugins auditd \
>>> +	uuid-runtime \
>>> +	sudo \
>>> +"
>>>
>>
>> Can you close
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests/8
>> if this series obsoletes it?
>>
> 
> I have rebased the branch and sent the patches over mail,
> I think i should close this MR in gitlab, i will do that.
> 
>> BTW, a cover letter would help structuring the patches together. And
>> please add a tag like "[isar-cip-core]" in order to clarify the series
>> target. That is all configurable in git format-patch/send-email.
>>
> 
> Got it,
> i was sending the patches to the community for the first time so i was missing some basic stuff.
> next time i will do care of it,
> thanks for showing patience on me

Don't worry. The submission looked fairly good otherwise, not like 
first-time!

BTW, I'm still ambivalent whether to do UI (MRs) or cip-dev based patch 
reviews for isar-cip-core. As contributions increase, you contributors 
need to express your preference. I'm used to both by now, I have 
troubles with both by now. However, we just need to consolidate over one 
system because we can't couple them reasonably.

And then we should document the current state of affairs, I know. There 
is a CONTRIBUTING guild missing for this repo.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--luqFKoHSjKClTR8dWoYI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4991): https://lists.cip-project.org/g/cip-dev/message=
/4991
Mute This Topic: https://lists.cip-project.org/mt/75699592/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--luqFKoHSjKClTR8dWoYI--
