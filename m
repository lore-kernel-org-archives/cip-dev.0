Return-Path: <SRS0=i0vF=BI=lists.cip-project.org=bounce+64572+5047+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20368C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 16:42:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C00B206D8
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xAeXw5xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C00B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5047+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3Ua6YY4521723x9GPaqFE5LT; Wed, 29 Jul 2020 09:42:51 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.310.1596040968989797965
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 09:42:50 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06TGgkAf010260
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2020 18:42:46 +0200
X-Received: from [167.87.13.2] ([167.87.13.2])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06TGgjsc010530;
	Wed, 29 Jul 2020 18:42:46 +0200
Subject: Re: [cip-dev] [isar-cip-core 1/3] cip-security: Add packages for IEC-62443-4-2 evaluation
To: cip-dev@lists.cip-project.org,
        Venkata Pyla <venkata.pyla@toshiba-tsip.com>
References: <79d0ae51-9d84-ce85-d6fc-95bb22bdc2cb@siemens.com>
 <7345.1596026360263349677@lists.cip-project.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <37d1e0f2-825e-e833-2b05-ec84cc3decbf@siemens.com>
Date: Wed, 29 Jul 2020 18:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7345.1596026360263349677@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lXulWzHOCfidkzhgfeFyxg5Ax4520388AA=
Content-Type: multipart/mixed; boundary="VPqNXiF9vKYVOq6NV7xM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596040971;
 bh=VQlZLaK3I0wiQBdmrZcyFYP+nk5GEpfhuoVaRVAuJNY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=xAeXw5xQzh825EjrStaxgVrlwmVDp/bTvTiAiN5kTdftrkuelAW6b21PiZdvqWDt228
 6rc8M4561EFoLXISE5t4C3VjHP0CrTAk7fzQ415SGqEJSkd4J3PBLpupYcviiPI6cJWOg
 DuCffHPK5YoMeW6XMhJBRmu5DPEp0lsRvnA=

--VPqNXiF9vKYVOq6NV7xM
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 29.07.20 14:39, Venkata Pyla wrote:
> On Mon, Jul 27, 2020 at 08:04 PM, Jan Kiszka wrote:
> 
>>
>> On 27.07.20 13:41, venkata.pyla@toshiba-tsip.com wrote:
>>> From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>>>
>>> Identified security packages are added to the target image
>>> and that will be used for IEC-62443-4-2 evaluation
>>>
>>> Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
>>> Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>    .../images/cip-core-image-security.bb         | 36 +++++++++++++++++++
>>>    1 file changed, 36 insertions(+)
>>>    create mode 100644 recipes-core/images/cip-core-image-security.bb
>>>
>>> diff --git a/recipes-core/images/cip-core-image-security.bb
>> b/recipes-core/images/cip-core-image-security.bb
>>> new file mode 100644
>>> index 0000000..a17c522
>>> --- /dev/null
>>> +++ b/recipes-core/images/cip-core-image-security.bb
>>> @@ -0,0 +1,36 @@
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
>> Still no CI for this. You can send that separately on top, the series
>> looks fine otherwise.
>>
> 
> To add security image in gitlab-ci.yml i need some suggestions...
> in deploy-cip-core script that is used in gitlab-ci is expecting *.wic image for copying the files,
> but because there is no wks file yet for QEMU it is not generating the image.
> 
> i think we should add wks file for the qemu target, can you guide me how to do that?

Such a wks file only makes sense when we switch QEMU to image-based 
booting, like Quirin does in [1].

For adding CI coverage to the security image, it would already be enough 
to just build it, skipping the deployment. Of course, if you'd like to 
feed the build result into automated testing, that needs deployment 
again, but possibly also more. So, let's postpone it until that is on 
the agenda of the day, I would say.

Jan

[1] https://lists.cip-project.org/g/cip-dev/message/4997

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--VPqNXiF9vKYVOq6NV7xM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5047): https://lists.cip-project.org/g/cip-dev/message=
/5047
Mute This Topic: https://lists.cip-project.org/mt/75820361/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VPqNXiF9vKYVOq6NV7xM--
