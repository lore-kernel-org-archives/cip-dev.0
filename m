Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D1DC30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 08:01:36 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.12830.1720166486827775840
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 01:01:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=S8Q0FsQp;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from [10.88.0.225] (dslb-084-063-248-163.084.063.pools.vodafone-ip.de [84.63.248.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 027DE88582;
	Fri,  5 Jul 2024 10:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720166484;
	bh=LXwuzJJuuDQqRlgVmCAAsfch6NhiEDv/U03Dh5/PXQc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=S8Q0FsQpdmOqNTGK4FNMuRbOHir6Wl5RS5cEXdTRI4/hqfNRkOLN60RdpE405iVUT
	 osHi1SqwJVLn6JZiH1GW4vJjfIEmLtyxXFQ/BW2tcxRXhtnS05g5e04Fb3ntguoNgX
	 k2ItUMtll2GiMXvwcFy8oInwlH3+3q0qvl7hLLlNhOZFps21zEDBgffuhG2DRAfViZ
	 oropz6FV+cnOxGGMAoJx+uVZKTl7Jr8E6ifnq+XoiqUejHj23jEm83TryNtJ7vrPh2
	 cca7oDsM7TGiiSihBSuTF4I4xSRFQKBDFuBZeYB+82wXq+Zq+I3A2lH6aGsayvWtQe
	 HF5Ud5Qr8fNbA==
Message-ID: <b1e44bab-4d90-4ca2-a6e2-7686ded2fac6@denx.de>
Date: Fri, 5 Jul 2024 10:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 08:01:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16389

Hi Felix,

On 2024-07-04 2:15 pm, MOESSBAUER, Felix wrote:
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index e91238d..5e54853 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -205,7 +205,7 @@ IMAGE_CMD:swu() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D$(ba=
sename $swu_file)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Create symlinks fo=
r files used in the update image
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_files=3D$(awk '$=
1=3D=3D"filename"{gsub(/[",;]/, "", $3); print
>> $3}' \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$=
{WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$=
{WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}" |
>> sort | uniq)
> By that, we also change the order of the files in the swu. Are we sure
> that there are no unwanted side effects?

So when doing streaming update, the order in which the files are inside=20
the CPIO archive is the order in which the files are written. So=20
changing of these files will effect that. However this order shouldn't=20
really matter when updating.

When doing non-streaming update, the artifacts are applied in the order=20
they are mentioned in the sw-description, so the order in which they are=20
inside the cpio archive should not matter.

regards,
Claudius

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de

