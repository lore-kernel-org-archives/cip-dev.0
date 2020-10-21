Return-Path: <SRS0=6I+X=D4=lists.cip-project.org=bounce+64572+5636+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CDC4363A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 20:16:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BED92098B
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 20:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uULL6SUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BED92098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5636+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gKxBYY4521723xJewWB8aN5k; Wed, 21 Oct 2020 13:16:35 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.94])
 by mx.groups.io with SMTP id smtpd.web08.18194.1603311393590534722
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 13:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3HjHioRJNZmDk6zZELR4K1Ljr/aNin8WIkbQ8s8Zsn0zH3oQV/m8nKKu3+EnkkK3sf8/NHg5H9DO5A19ECh2+C1NqYvR7oDjstqFCnA4VriWGprYv6xT8OF3JxhsRCStzZF5yUyByuKWtQcU1ihQi9A+lmSYDUkJouT4n0yJPTCEVIdBp80z8AUPVlAZa7UuIyOBB6DSdoKGF/i96w+v8rTjdWpY1rD5Ts8saZpIuNhB7ls+5PvVVuRyjRFKROj2cWwxNSxzsV2kNR8ze6rK9z01okCsdrz27kWHjPwS2qaK6bDKrCgjcdyHlOkdnCv7JqZAhqQJtdzvHlCrKS5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK5ZtdqWkfM/VPdYVlWJ17G5wb2JgBzh9tTQGxhrXa8=;
 b=lCfuPdNC5ZbxAMe9iIMb5vvZSoBFKXuinrVaNFx23FTzkGaCV126+YEcRbjFoPC9RvRVTkKMxKQvZN1uuFHKF9eITAio3s3CdAetzUoUbbvDLMyyo/mHfZR/OC0QygPSl0MT9QJkPrsLpIhIbHcbuT9PWxXB2LIZfztM9c/SOoltdqiDm5q2q40FegUgVoZK37l+sbsiRQgBMcV7YGEiJ4O2M6NU4iQxxu+qOMxecHDLli1YmTR0XVLp0c/5HDybELTKn9LQSK5o26374N0qnP2phM2/+QnGk8N1jZYJu4ZyvCTW8A1J/b8OcV7WyZ/AqGkDDf1L+FrfweF2qtj/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSAPR01MB4978.jpnprd01.prod.outlook.com (2603:1096:604:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 20:16:29 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 20:16:29 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 28/50] PCI: endpoint: Add notification for core init completion
Thread-Topic: [RFC PATCH 4.19.y-cip 28/50] PCI: endpoint: Add notification for
 core init completion
Thread-Index: AQHWoKLSEm2q5a0Xjk+gAQ6cE7tcwqmid54AgAAUmNA=
Date: Wed, 21 Oct 2020 20:16:29 +0000
Message-ID: 
 <OSBPR01MB504859FDDE160AA0AD700744AA1C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201021190030.GB10468@duo.ucw.cz>
In-Reply-To: <20201021190030.GB10468@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba763800-145b-49bb-8ee5-08d875fe3244
x-ms-traffictypediagnostic: OSAPR01MB4978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB4978490B18F40B4DDB221981AA1C0@OSAPR01MB4978.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yGxQ+5BY760PgrmsKvk282CfUUnBViBRzi4UbvLK2aLkkhu2Czj8EttwuOgMddYQJnzstaj3O4dMISrS3HaDnpnFEbBdXgKHS2HcoBZm+e4h9V5JRYNqLoIvEp/5ftoGEv2LbS0pzYo2fi5VnyFRdriMuQ3UTKRQF0j4qn3VqUwpFhP02cfOuFgCYzKB0bNIPHjeujhzKWGGetJxyuE+pdawLWcVIjm3NjKDC5A1xiA9JsLrt3mYqF9nslyjU+DYJ/2E6pqxbunfC3WcB3u/dmrppdpaYr+qsY5yUVclKdMZvhL5BEtpCspUv56N3DRn
x-ms-exchange-antispam-messagedata: 
 zGRUtV2YLQDrsG6NjfwLX+fzpYZeLdPdaG2VPqMcHRj80IRrkpuYzWJjgwEpdWct4rs4ONcHrVKsRRB3xwiTdC+PTJwrRVvOqLurHpkovbCbr6WcNbzmS0L9I+DhVTFURf+bY9oRYkuTbE0hpw0nrogvGSI7eiuK84YLZTfEimLeyHgwK9g2Mz/uqbxrOwDN2uWI9QtkLLyVrFkeIg6ZNjDGfdN3cx/RyqONWDDCC/CKW0JN8Nb/NBjZFJtEn+wzLi+eUmsNmDInaNaf66HDT9affakJyFnv9De/V6bFTM9wk9H4PLYAsH3Ol7VcJvP9z9vsHiq7sQxygbI+1DzKzADXsTs0yCiJkxHKup09JxRCpFj49t1OfRUPlzGcGq6ul2dKMKJGCzdWpuASKXO88Oxzr3XYb29V5f1OG7aJfbwX9n+MHAFESYUTj7RzhIDPqFOZ2wJWwz4+hZuEsDnMJRiySpbCvoL9aFYKRLLAnfK7oRIsbdQj7zK4BN5osBqEiHFQ7gKwjL+nl9icaYaovROmEJW/HEIzkyZSTQ5z3TIgP3MqpFeCiiAyAgF1FRXv3ooO+bWfoCTCBafTShgvOKT9HBaVEu/wYRPJi0Yiji7nxx3g0/SH/Yido/9RIXP5uVVWzigDjsQDF/1LLYjh7A==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba763800-145b-49bb-8ee5-08d875fe3244
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 20:16:29.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlyV+RXRmU0lTsBHoer0sxttq/IdMvBaGN1fwb8isi2Qty/M4XnMVuv0mukykLJ/oSZD2gGi0k5W3avyfaOh3jRWN6kCTbpxPMgyfruX4PgxC/4DSl4uh71WPZPYk/9Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4978
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: d1298eidrpdajDqIIcokmEZQx4520388AA=
Content-Type: multipart/mixed; boundary="uICWpEpMltbOxDK46uEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603311395;
 bh=cq0v1K6lzWiLD8zDn/Mzbhrzw+bxgedJs1+FVn3kYJM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=uULL6SUw9261o5InYjxLimtAPQetMzZGh8/Hv64GvhyadJ33/Pedwdk/vCev8d9uFRt
 cdRIllf9chXrR9Y55TrtGmkUfUg1qYm2xnV5mBVVbPCLaVWbwpK4q/VxzWIqX7TJZ/v9w
 Udc13jhEKL8sOIz3nN4lad9VkCOkIxFgcN0=

--uICWpEpMltbOxDK46uEs
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 October 2020 20:01
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 4.19.y-cip 28/50] PCI: endpoint: Add notification=
 for core init completion
>=20
> Hi!
>=20
> > From: Vidya Sagar <vidyas@nvidia.com>
> >
> > commit 0ef22dcf0c1871888c4c0ee46a9d9c494f2fe997 upstream.
> >
> > Add support to send notifications to EPF from EPC once the core
> > registers initialization is complete.
>=20
> >
> > +/**
> > + * pci_epc_init_notify() - Notify the EPF device that EPC device's cor=
e
> > + *			   initialization is completed.
> > + * @epc: the EPC device whose core initialization is completeds
> > + *
> > + * Invoke to Notify the EPF device that the EPC device's initializatio=
n
> > + * is completed.
> > + */
> > +void pci_epc_init_notify(struct pci_epc *epc)
> > +{
> > +	if (!epc || IS_ERR(epc))
> > +		return;
> > +
> > +	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>=20
> Is this used somewhere? This adds symbol but noone calls this, and
> AFAICT it is not used in the rest of the series, either.
>=20
Yep none users (only dwc uses it mainline).

> We can merge it, anyway, I guess, but... explanation would be welcome.
>
Ill post it as part of non-RFC feel free to drop it.

Cheers,
Prabhakar
=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uICWpEpMltbOxDK46uEs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5636): https://lists.cip-project.org/g/cip-dev/message=
/5636
Mute This Topic: https://lists.cip-project.org/mt/77461704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uICWpEpMltbOxDK46uEs--
