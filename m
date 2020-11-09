Return-Path: <SRS0=Z4El=EP=lists.cip-project.org=bounce+64572+5767+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B7C2D0A3
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 09:02:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A15206ED
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 09:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="v4O1h7Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A15206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5767+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FkZ6YY4521723x1AsViNNkz3; Mon, 09 Nov 2020 01:02:49 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web10.8877.1604912568498567337
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 01:02:49 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0A992i9K001904
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2020 10:02:44 +0100
X-Received: from [167.87.33.169] ([167.87.33.169])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0A992h3P032209;
	Mon, 9 Nov 2020 10:02:43 +0100
Subject: Re: [cip-dev] ISAR Populate SDK
To: Rajashree Sankar <rajashree.sankar@sanmina.com>,
        cip-dev@lists.cip-project.org
Cc: Lakshmi Natarajan <lakshmi.natarajan@sanmina.com>
References: <CA+UxhRq6YpeHNwGUFB1bxGbgJUG78qh3497mCj+UEahs8t+JEw@mail.gmail.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <9462f90b-ddb2-cd8a-079e-0d7dd94d9510@siemens.com>
Date: Mon, 9 Nov 2020 10:02:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+UxhRq6YpeHNwGUFB1bxGbgJUG78qh3497mCj+UEahs8t+JEw@mail.gmail.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id 0A992i9K001904
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: a36YaIHv0fyq6Zr04TPC8ZJXx4520388AA=
Content-Type: multipart/mixed; boundary="Erud0ZtPFpESIedh7j8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604912569;
 bh=+9FSYSQJyvE6KXVRXY/HjZ4T0RkrtKcMI9+kH9KXAR8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=v4O1h7VlMW6W43UkvDyHwbGSqNAeuOjcpiF5xkee1lgrfy6BQx53OBi4DMs/vznNJOS
 NpLZSou7b0x+Ug7VdkofrMqEV1v2PDWRvR0v/uWM85DgJZveKvWzRBjwa8XeVOZZTfHqR
 vRcJKpcnq9qxN6XddPkOgMbWkfNJW4tJPrI=

--Erud0ZtPFpESIedh7j8N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 09.11.20 09:56, Rajashree Sankar wrote:
> Hello All,
> In the ISAR framework,we ran the command to generate SDK
> =C2=A0 *bitbake <image_name> -c populate_sdk*
> There was an sdkchroot=C2=A0folder generated in tmp directory.
> The instructions given in the readme of this folder tells us to use
> rootfs of the target.
> Should we specify the rootfs=C2=A0 folder of the generated=C2=A0image? =
If not
> Please give us detailed instructions.
>=20
> I have attached the readme file for your reference.
> Thanks and Regards,
> Rajashree Sankar

You are on the wrong list again.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--Erud0ZtPFpESIedh7j8N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5767): https://lists.cip-project.org/g/cip-dev/message=
/5767
Mute This Topic: https://lists.cip-project.org/mt/78131876/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Erud0ZtPFpESIedh7j8N--
