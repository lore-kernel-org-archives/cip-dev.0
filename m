Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE9C6FD1C
	for <webhook@archiver.kernel.org>; Mon, 20 Mar 2023 20:15:03 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.118])
 by mx.groups.io with SMTP id smtpd.web11.4435.1679343294097000560
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Mar 2023 13:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=kaM/k7/i;
 spf=pass (domain: renesas.com, ip: 40.107.114.118, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALb6/ILgia6kFZusqZ9YsuVMdzCtDRM0XicBP8j+CNWKIzhbiBXEkk4nNtvvOV2jcNpPiZqddVr0S5N2Ft/FjsMZ5dNKaPp7dw/Y7RgvTHfqJppke0YnvLLsi1fR9Ze0jAhbUYl199PynOmRd7r4HPIvIWoZeSM9iwnNjbXZjv7PEE8UsPpYrFnCgpGJCRfMSKFUWdXZTbtwArm2KqEsqoYm5RPmOEJmfqdt9Z560QR/cEqoXuFg0LP/zb5P1F/cQNuKURUThteyCAq8wmc5XDGVM1t4U7KemHnIYNQylvCMVf5hD4lJVR+CfCGSXpLVukDLb/bq+h/JxEkYd3Evkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yD4OMkQ7Dh3OTpCSfA/8UhZ83buyapBf7at7sB/060=;
 b=inUQevTKSTErGmrTNepJm+lXXbgs9xgGcgiidNDo/qZhDRL5D+Cm6Rp/qfbLKVVusjG2/VD28kc8FgpG0zach2Sq9Djt/ToH79PH0y2ZJ3ewvauLo0hJqPnHoswG0ndufq6awrS08vIE+uyMd3iwgAlUqJs/Tiv3+mXpKHmr30vfADNquEBixCXvhV8QKcvMdFnK2b00YCWDXu8EiGBpvVI0h//i6suoyRW+nbEqK/uB8TTPKMpxn4e8HxkH45kWGaGu4FBLnJ98ENuyhBqd/7SGbE8+x6M3OkHUyykBnPXkLV0uYtaAp7saV7IIFZgEpNBiuS7J9gudF3MSHpAFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yD4OMkQ7Dh3OTpCSfA/8UhZ83buyapBf7at7sB/060=;
 b=kaM/k7/ir8JsKWo7CMkV80Zd5oBLSRUBWF4KWnT+ftE0svi1e1lJJyZaq6EPl/8wUszu8IukrUwdDrBdDkjVcVdy/V1RmukR0AsWnBW/wmscjETKxdN6Cz1mk7S0F19hBdrwh/+rQOo+1on6Ou5ebzdI8RMQmVVeRmy+N3Q2aAo=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OS3PR01MB5814.jpnprd01.prod.outlook.com (2603:1096:604:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 20:14:50 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 20:14:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: cip-kernel-config usage
Thread-Topic: cip-kernel-config usage
Thread-Index: AdlbZz6mEi4lbxV/Sw+U05Wy/alWrg==
Date: Mon, 20 Mar 2023 20:14:50 +0000
Message-ID: 
 <TYCPR01MB1058893D2499CA38B024BE0A4B7809@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OS3PR01MB5814:EE_
x-ms-office365-filtering-correlation-id: 5719d36f-6265-49b9-88f8-08db297fc26c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 okqOEAoSlLHSPNyhRyqkGdvMyedoErL2kQSRgHOp/OHr/uI0uWgQXNpHjSz/f1wVaxIhVDqGJJRzsnu1fALWmUJIPv4SRKXQDbJt95qQJNgy/bM3E5HXBRRYGTn+MWFSKFi1dQ51lM1fGM0BoLlIcQD7DDwBenD8UbKeWOuqi5xyDTsf5fnR+bOFgEGctSjREt6o7CDtA5SaMinAma1jnKSbg6zf5Xpmfe/nymSWuvN9dc1aQ6htGVvF72GU4X0GQGBVT4bIfkwuTfueZXZSBS8CXfbnacs4Sl/me8LJPfonwHnJKYnw57559iYBZi6S+4D9NED1KFMIqL8CB1UHbEIKR6bLUGviniiLOxgeOm2xzkYey9j6bCNc2BqKOnh2FQKGY/XqmLLOgT2rejNeVKcPtv/rAwBBiWXQoc8e78oA37rVUvD739mFb2J1V+9CrfM3aU3TxayVTAT/iPdknN1bTa4UWjYB0Og9SLY8xFFM+241I8dV3Pwu8oZOxMd16xSg3DUd/LYybBgpg9XXlLOVAuZNtQ4AOCj1HbUEde3jnfG1925xUS6GmV8IpW6nwBcNOasO7PquQdSqpFV6CpqrWN0elZdma99Jif1LQbKyrpEvFcluPWWguA8X97Z0jdRBcEWMqYTgAaZxiikXl4juSTVk/T/Wi2vDNggnQ/AKltE3kp8Emz+Dw1iH5q3anliTW2oA2cQL9pOdTRU+VoTthM+qcG0hrgzpDiRkb/Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(71200400001)(7696005)(83380400001)(9686003)(966005)(478600001)(186003)(316002)(64756008)(66476007)(66946007)(6916009)(76116006)(66446008)(66556008)(8676002)(3480700007)(6506007)(26005)(52536014)(8936002)(41300700001)(5660300002)(38100700002)(122000001)(2906002)(55016003)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?DjWR4IkyrcZ4wCXdf1eCnhnIJodVnz+2aR67IHwJkxC8eK4uJbmmVtIVob?=
 =?iso-8859-1?Q?8BnOD+Gp5m9URpbRfkZbuEVXPbcgpN6KB32WhtXrtmhyrFIVLB4uCRtfpk?=
 =?iso-8859-1?Q?hLklDjzBSXu5JkHT44QMPro+XoEAl4d2j8xzVi/5Jr1m09o0f75m68RZno?=
 =?iso-8859-1?Q?ZRUxY6st4c5VA6Xr1Rcti/g++PY5d/OfGQNfqPEt/Y+XE/Xn4jeAnEsqqK?=
 =?iso-8859-1?Q?GUW9RHqdWQKitCx7dQya2sXSFhFxtedWIlAZ9k2N/jY9N0fPQ4E9OcGwsp?=
 =?iso-8859-1?Q?vdQMhdPRKs7ivH0JHa8EVBhxzw21CY98OmSBFV+rzBHDzdfYZSJnt96R19?=
 =?iso-8859-1?Q?P/cKZ6HzkZGUd39TQfZ0uMjd7Z4gtUgqMsKCm2Xq6Z3VXXHi0fQuuKjhhP?=
 =?iso-8859-1?Q?7LztOupNEkPceyj4oVUa9ZxwPj3t9HgzgjCgE1FPUvRGYNsYd4ejzH/Vhe?=
 =?iso-8859-1?Q?xjfOtv1KevTM/vWvJdneDvhcffB7IkPnjkB4yrvlRrHrXr3quowg/njKtX?=
 =?iso-8859-1?Q?pkJpNR3tk2Foa3FyTpyZ0ZOHKzEm7tviSrOtCSdTQ2LuLJGGT9RPdYNYI7?=
 =?iso-8859-1?Q?WAcLwh0hHVsEzz5UX71+BKf07xAvc/J7suhhoAqpwUE7ld3xiYCuPXAKnf?=
 =?iso-8859-1?Q?wCTR1b7vibD310tMiNR0esKXpOxKdGaUv4SITe+szxx1cUgg/wKnk9sAdS?=
 =?iso-8859-1?Q?bqDvAxO4Fi0Jn/OBa94roK04h6lcE/pC2R47lYve7oWZfwUsX+pFlSoVjg?=
 =?iso-8859-1?Q?yLJ8v28GlbFUHDKyf+sBHrTonF+eg3u0A/Sp3ZgZZX15UXSgQWkIoV9J77?=
 =?iso-8859-1?Q?N77jXeGxAmqaSCBGfgwcGH+ev8R3zHOdZqwNIwsKJO4V0RBuDDhnd5bgxQ?=
 =?iso-8859-1?Q?GxNbT7vn+7f6O6Z1vg3PHLjvKaVGotGVQTgYvdk4pdaPKgc0kk5S+eUW0x?=
 =?iso-8859-1?Q?gn4pA+1rQdMnLjYHdcCP0ZTFRupD8qZUha46pIcK32yo6ODKLVstkRYB7p?=
 =?iso-8859-1?Q?5i5vPWVEyWPJ1bHjLhwjWF0XyKyUFPi3wkuGpoZW38E7DOdC7Skv3OFVoB?=
 =?iso-8859-1?Q?7knnFtBmq9rEJ+udKcvEmPAZcMCyIoo8HxRbs2VizLlZkIhXspmd4CFMlf?=
 =?iso-8859-1?Q?IdcVkogWX9weghirgiYcmMn4WZ71aqJz7/OhlUh7mqWcLUe0BrU1a55k48?=
 =?iso-8859-1?Q?5NiY7fxkmC32lCfxmRxJu/TyzT978rI7tR35WrYxZGl3Pi8Km//UXC7L16?=
 =?iso-8859-1?Q?8W7TG9x3TFeaRgjkMxkKMpmQ+9meso69Ny/c7JcnCE8ZqfrZnYWoY1EQkw?=
 =?iso-8859-1?Q?N1khA48apPxrkGP59+vR4uIIqmfCB3xZPZjZ0KZ63tJnLh3HLwhqXLI0zW?=
 =?iso-8859-1?Q?/arGkhb3N1MCsuSlD3TSEhbSgy6D9mCtZ96VpzqQHfNw4G/1Rytf97/oYO?=
 =?iso-8859-1?Q?LtCFVkSrcxlPkBMg22R5XULCXsT9mTCxTX/m3VdEO5T9p7s8VyDyXiRVj2?=
 =?iso-8859-1?Q?EpiVUqwXOi7FOuXK1rXABmNF7J3BwLoqHxwAJXeJcKiP3vb70IgLbcxsAZ?=
 =?iso-8859-1?Q?3t1XUfdmhhlYQSbGZTZzNUB1EuaKAMSSPAlDLXY3Orj85MDYNceKJ4x00W?=
 =?iso-8859-1?Q?gxqrz0M6+/TW/vV9Vf53I8vKDsvVvp026LIg17lZyTQk4NGBPSWQDE1A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5719d36f-6265-49b9-88f8-08db297fc26c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 20:14:50.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvEkHbWgn21ibLuz60WANFsmhSnmxShq8saAWrKNVk44W8tPGdyScpMHtRnMF/HnNbtpXmMA0sucGjq1du8GcYme2ypGp562NuLbvAQLbwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Mar 2023 20:15:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11039

Hello kernel team, all,

The cip-kernel-config[0] repo holds the various kernel configurations which=
 CIP uses to maintain the Linux kernel.

In addition to .config/defconfig files, we also have various .sources files=
, which get generated by the Makefile included in the repository.
My original understanding (backed up by the README[1]) is that these .sourc=
es files contain a list of all the kernel source files used by a particular=
 config(branch/arch/config-name.sources), or for all configs (branch/all.so=
urces).
These files would then be used to help direct the efforts of the kernel tea=
m when maintaining the kernel.
Is this still the case? Or has this practice been stopped?

Also, there seems to be some kind of "warnings" configuration[2] which is u=
sed to define kernel configurations that are not recommended to be used.
However, we only have this in place for 4.4.y-cip[3].
Do we intend to ever revisit using this system for the newer kernel version=
s?=20


[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/README.md
[2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/README.md#warnings
[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/4.4.y-cip/warnings.yml

Kind regards, Chris


