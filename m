Return-Path: <a-gupta4@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E97C5B543
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 11:38:39 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web10.5278.1749123514517529303
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jun 2025 04:38:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=Kyvnb/l5;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: a-gupta4@ti.com)
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 555BcX0k4086356;
	Thu, 5 Jun 2025 06:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749123513;
	bh=ww3IbeBG4BBZwnN4ZTuD87Dqov756cozeFLEN/a+rtM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Kyvnb/l5WtViWvVxSh9p4o6yJ6YjxFTBzP55LhBgSWMnfv8Qly+Q4DDSoF4S3xFO9
	 w+XjleaoyQ9ZcKd5G2qgRck4jT0IJF9Tj1NI3ZaaOj+t2gWxKuzhtRI/UUkUQ8UGBn
	 ITWJbR7Z4hMuUJpXdlvBenHKH8/e3TUWb7XV5fnk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 555BcXt8785287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 5 Jun 2025 06:38:33 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Jun 2025 06:38:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Jun 2025 06:38:33 -0500
Received: from [172.24.227.243] (ayush-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.243])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 555BcVbC3612868;
	Thu, 5 Jun 2025 06:38:31 -0500
Message-ID: <1f4b588e-25b8-435a-8ae4-cdfd18b86b9b@ti.com>
Date: Thu, 5 Jun 2025 07:38:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Secure Data Encryption on board without TPM support ( AM62P)
To: Jan Kiszka <jan.kiszka@siemens.com>,
        "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Adivi, Sai Sree Kartheek"
	<s-adivi@ti.com>
References: <82039e1a1c384350af46fe375650472c@ti.com>
 <fc47ba94-4f48-496f-be17-577742db6598@siemens.com>
Content-Language: en-US
From: Ayush Gupta <a-gupta4@ti.com>
In-Reply-To: <fc47ba94-4f48-496f-be17-577742db6598@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by fllvem-ot04.ext.ti.com id 555BcX0k4086356
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 11:38:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19024


On 6/3/25 07:16, Jan Kiszka wrote:
> Hi Ayush,
>
> On 02.06.25 20:03, Gupta, Ayush wrote:
>> Dear CIP Development Team,
>>
>> I am currently working on enabling encrypted storage for the TI=E2=80=99=
s AM62P
>> platform, which, as per current hardware capabilities, does not includ=
e
>> TPM support.
>>
>> To address this, I have implemented a working initramfs-crypt-hook-
>> nontpm (link provided at the end) =C2=A0solution that removes TPM
>> dependencies. It utilizes a keyfile embedded directly into the initram=
fs
>> for unlocking encrypted partitions during boot. The initramfs itself i=
s
>> considered secure as it is protected by verified boot (Secure Boot is
>> enabled on the platform).

> That should be integrity protected but no longer secret, no? Physical
> attackers should then be able to retrieve the initramfs from the device
> and, thus, also read out the data encryption key. From there on...

You are absolutely right- the keyfile can be extracted by a physical=20
attackers as it is not encrypted.
We should find a more secure key. Thanks for highlighting the issue.

>
>> I would like to know if this is an acceptable and secure approach from
>> the CIP security perspective for boards without TPM support.
>> Additionally, are there any recommended alternatives or best practices
>> for strengthening this method in scenarios where TPM support is not
>> available?
>>
>> Looking forward to your guidance.
>>

> Did you already study how we are exploiting fTPM on the AM65x?
> https://github.com/siemens/meta-iot2050/
>
> Jan
>
Not explored this fully - but will check this out also. Me and the team=20
are also trying something more on that.
We will reach out to you if we need any further clarifications.

Again thanks for suggesting this repo!

Ayush


