Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F0C282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 16:51:21 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15658.1740675079642964324
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 08:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=YSQEdlM3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BEA210382D2E;
	Thu, 27 Feb 2025 17:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740675077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D61ZhAgL6CSr1t+ZwAKRwNBGuUzaAmYfvjI8F653RQM=;
	b=YSQEdlM32uc10PIuUqZ/2ZvB1ggoYXtlqaofNgRK4T3qhV4A871PN5J5ly4nvgqQZSgRtv
	l5EvpPlNyCadBNp+Sl1JjRIMcM08KQND0/5XWbxVHwB/n8A0r9RU9TsGheH01atgAMtbe5
	YD6FbSc/vIaz/KWIMjuRf2jwyMZdOAJQHZ1p3Yz3zVEuW2yfpMI62g1S2S8pyR/g/qpva1
	IycL5YSwzmgwcOT+4Exvr94d/IJBKTZP5ohOv1QC7qy4Ou9vGk2fT/TTf9ZFlJlPs7DC/y
	8/fwPB07Cynm8K4k95ZZz4XnOTKunt660bMss7blRzWpyI1cOivtGEai3yMclQ==
Message-ID: <3660a130-4976-4ace-bef6-e83e1cce5645@denx.de>
Date: Thu, 27 Feb 2025 17:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-3-ch@denx.de>
 <56a7a225-2213-49b4-980e-0c288b1e8874@siemens.com>
 <01544894-2abd-4f58-ae7f-4ca43e137138@denx.de>
 <fe273710-8c84-47ce-bcfe-e7df71d9b553@siemens.com>
 <1396788e-f1be-44f1-9efa-30bd01f3896f@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <1396788e-f1be-44f1-9efa-30bd01f3896f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 16:51:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17979



On 2025-02-27 5:46 pm, Jan Kiszka wrote:
> On 27.02.25 17:07, Quirin Gylstorff wrote:
>>
>>
>> On 2/27/25 15:49, Claudius Heine wrote:
>>> Hi Qurin,
>>>
>>> On 2025-02-27 3:42 pm, Quirin Gylstorff wrote:
>>>>
>>>>
>>>> On 2/27/25 15:30, Claudius Heine wrote:
>>>>> In case encryption needs to be enabled via an update, while still
>>>>> allowing the update fall back to work. One update step where encryp=
tion
>>>>> is supported, but no reencryption is taking place if the device is =
not
>>>>> encrypted.
>>>>
>>>> The scenario this patch tries to solve is update from A to B:
>>>> - Update is not confirmed
>>>> - the encryption was successful
>>>> -=C2=A0 Error occurs and we fallback to Partition A
>>>>
>>>> Is that correct?
>>>
>>> Yes, and it is about a shared data partition, that needs to be
>>> available on both systems and should eventually be encrypted. The roo=
t
>>> file systems do not really matter, because they are belong to each
>>> update slot.
>>>
>>> Update slot A needs to be able to mount the encrypted partition, but
>>> should not encrypt it.
>>
>> Can you add that example=C2=A0 to the commit message.
>>
>=20
> Actually, that should better go into our documentation so that the
> reference case is also clear to users not parsing the code history.

I have described this scenario in the documentation with in this patch:

 > For example, with a shared data partition, the fallback system would=20
have the `noencrypt` option, while the encrypted system would have the=20
`reencrypt` option set for it. Now the fallback system can still open=20
the data partition if the update to the encrypted system failed.

But maybe I having it more structured instead of just an paragraph would=20
make it easier to consume and understand.

regards,
Claudius

>=20
> Jan
>=20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


