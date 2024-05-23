Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE161C25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 12:05:10 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.64])
 by mx.groups.io with SMTP id smtpd.web11.15162.1716465904429506774
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 05:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pwo1pGKs;
 spf=pass (domain: renesas.com, ip: 40.107.113.64, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anYFE8fLcIFXGX24nyaKtqHVLVoNzh//6YWU2GIjKq9HvbJ4r/ecHievxuVunZpy2bKnk8wWXj9KEByehOIf6reiIC9MF5wSykUKu2jcxEms8koj8DOqrwwlO9gZ7PIqRZCupJBwSJd4LFkRX4gOQVzMRLRB0yHKoxQXgMfAtqQuDN6gL702V63f7p+5EHbTTc4/HXZXlZ1eLiJqLiZ7zlE4z1O62mgS3lLb/p8q+iKESdZZkk8Eqj2pMGehLhVPekmnvApfcRpeMsr2QJB8m/w3hytvKlWZKDpNY5Gxe5DcHpvbR7fIqxdrVzzFNIzJGd42TQnY9NR0Qugk3PP93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j2q0VA7TLSgY2LrmHnqAPofGa6u2C5D/ysSRgkMZ7E=;
 b=Tm79+jNLkGS2i/KART3D2spB+J6KCshTkdnHGMZOapM7xHyi0oNEHrVfgcZFH8tL3aYgHlEcHKbF52PlMIepjM/utGGAjqxYN1FaRPk6589UicmaF9KBtwejn1kzxL4jDAL5GjxIQ/OCQ6R3N5idnO19HsHVo05BmHZ3Iabv0sTc6qSpx1jnhow1NL9soZA8sRt/dbkRaJxRW79YZeQIBgEk8XQ4mk8m6iUnrVAFEDeu7xqPeVsGOKvQmZgYGzdwUQbQQDmX02Xi93KELjoHOe1qBo5pIwbbV3xJWip20E7e93JWRpMVhJcg+F8H9HMTT8feWOptiGkxN9crrNNsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j2q0VA7TLSgY2LrmHnqAPofGa6u2C5D/ysSRgkMZ7E=;
 b=pwo1pGKsChgQFSBRymGEr5zPc0SKJsqiEonk4KCWrJINoYL7LTylcJc7SoUu1H/GBamOM5Tf5z1/hAA0YczjTg+eLUxbv3v4LEm0jjcoGC/KkXBiXbY8+qtVRnLH7wAmrx3B1uqzMYFvbVrn9bqKS827Mhog5ZGkeN22vwaEznI=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OSZPR01MB8669.jpnprd01.prod.outlook.com (2603:1096:604:16c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 12:04:59 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 12:04:59 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: AdqsGtXhN49/gNbeSoqkT+RmP+DvBgA7UV0g
Date: Thu, 23 May 2024 12:04:59 +0000
Message-ID: 
 <TYWPR01MB11862579C41345AE192CA8CA4B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103E0981B612912E2324AA4C2EB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103E0981B612912E2324AA4C2EB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OSZPR01MB8669:EE_
x-ms-office365-filtering-correlation-id: fde4eb26-86ca-445a-3523-08dc7b2091bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RnZIYlZxRXdTYWhDRGZqNzUveVFiODhIN2dCWWVLZEUrQ0pHTVE0RWhk?=
 =?iso-2022-jp?B?VERIcWtxZkd4NGlMSXlZdTVUOHo3R012RU90T1IvYkt2MllHQjFtVWNr?=
 =?iso-2022-jp?B?WkhWMTN1cXNMaUVxZ0xLVG45MlZPcHRSeU5xS0xxalJIUzRTcm1lUG5F?=
 =?iso-2022-jp?B?K3B5Yk1JSGdMR0xEbEVVdGg3dGRwOTgvanlsdXpFeVFaRlBwQkdFQmlw?=
 =?iso-2022-jp?B?V2RwSVM5TUJ3MEJUd1ppc2grUGh0d1p0SFExdjBPWUdtRC9raEd0b2xM?=
 =?iso-2022-jp?B?Z3hUYkhzanhHMEYxcm9Jb2FTT1d6K0h5VmpCMlVmdGd5SHBQaHlJMUlm?=
 =?iso-2022-jp?B?ZzRPeURzYlFiK2hpSVc0RHpRbHdNTW9kT2dGMkZ4WnFPUHk5WU03TXZv?=
 =?iso-2022-jp?B?c2NpQm5IM2J3VzVBb1RrN003MExtRGZnZ2pUaFRKU1Ezbzl2OE1PMEQw?=
 =?iso-2022-jp?B?MVRjSlpSUkwrb3YwbGgvdUhNTVZJTnhVazJKeEhteXFLTEdtY25TK3Bn?=
 =?iso-2022-jp?B?ditnd0NobDVoakp2MGtvT0o3UXMrSTVlVkk1bm05NTI2Q1ZqWTlFMnRG?=
 =?iso-2022-jp?B?NFhpYWI2aDB1amRPYVN5QkhpanpmQVJJOVVUNWVwWXBKbCtic0t3QytV?=
 =?iso-2022-jp?B?bUxrUE9TbC81WFMyRUdNQmtzRVYwQzlKRGVZV2c4eHg4cDJHSzN5dGRt?=
 =?iso-2022-jp?B?WkN0cTlEeHFDSGRkQmdadGkrazVLTUYwZFJ3a2c3VWJ3T1l3RUNTUG1q?=
 =?iso-2022-jp?B?TUhUbUplL1F1L20yazNOdHhmVEM2MUJsZHI0OW4rTzU5Vno3MWtOSkZO?=
 =?iso-2022-jp?B?OURlUG8xeDNPQjlaNHBYQ29LcXpiaS9CV21mcFBiTnl3Ni9Wd2pzK2Q2?=
 =?iso-2022-jp?B?c01ZNlNFeW52eHFKK2UzUkJNZVdTeGVzSXcyVHZhUDFKaVpERGVKSkV3?=
 =?iso-2022-jp?B?bWlscVZhelUwcWtYK0JRUVdHYjhtc1VhT0h0L2tYKzFsYnowc2UvN2NG?=
 =?iso-2022-jp?B?MS9sU2tGMks2ZE0rYVRhNHlXRUZza1VUQ0E1amZMc1c5V2JBUk5YeHNV?=
 =?iso-2022-jp?B?NE90a2dsbmdySmRZNDVJZTNCV3RCVWxQTTZMdFF6NjBPU1Rldm5GWGdV?=
 =?iso-2022-jp?B?N0poNUxpRjRQZWZmM21OeUtQMWdhSmcydDZoZHJ5Qzl2Mys4Z0x3S014?=
 =?iso-2022-jp?B?TUVPcTdLdURjQmZGUU5BUUk5Y1pCOGU0YVhUSCtLMDQrMGhnelg2eEt3?=
 =?iso-2022-jp?B?Zkd0RVV5UytlLzlyZ0ZMZ2h2cktxUTllYVJRWnhqSkdsNzFmR0czbWxD?=
 =?iso-2022-jp?B?QlFNZWkzSjZmeGpOL1lxelRnOEY0N2FpT0JaL3luRENyN3RYQVJKUDJM?=
 =?iso-2022-jp?B?T0hFZWZtaldpSG1WZHhXTVUzYTBkWHl6bk9SS0RneFgzKzBVSGRKYTBr?=
 =?iso-2022-jp?B?VERFRElCVzI3MXh6TnNNL2xjekVVL3J3b2w0SEZnSFdmenJNMHZmQTl2?=
 =?iso-2022-jp?B?dFNNMmN3RmZwVzU4Qm0yZHpuRXpnZ2l0b0dwYSsrZWIvejc1SFpZN3VI?=
 =?iso-2022-jp?B?aWxRLzR2Ync3Q0NPMmY4WmZQOUVPWk1yZEhwRk9RYWw5VzU1WENGYTN3?=
 =?iso-2022-jp?B?TkRPTGUra3VzSFlGTHJCUVRjRzRHU0ZlMDlwMlVjRkJiUlJVZWpiNEFy?=
 =?iso-2022-jp?B?MEgzaklFd0RhOHZkcVJYYnlCMkR3aDliZnFURWl6eFF3cjUraXZzUGRh?=
 =?iso-2022-jp?B?SGdhWjZVbjV1NnRlSnFqSEVQOTFlamJEeWd6ZUlpcGozc1IzZWU2VzJk?=
 =?iso-2022-jp?B?a2llR3kzM2FlZisrQVFKckNnQ3NnUGJreFJjRDIzMmJHeURYT1BUQ09R?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MFlDT1ZKaGpjMExQVHIyNG13bnBPN29tdVhqSE5Nc0hCT0xTQ1lCTE8v?=
 =?iso-2022-jp?B?MU1MSnVzamhKMDYxb3k2azV6dGRBenVpaERCUlJET0ZtenFVeWo0WUhV?=
 =?iso-2022-jp?B?Vmh6Zy96UHdZU3BZZEwxZWpKK0JRVG93UDVxK1hKdTRNYTdoNmZsQlRJ?=
 =?iso-2022-jp?B?L3BLckJ4WDVwaXdyWDBvdi9IVVhUc0lSWDVWcGhFVG1xVFFPWXN2eWFK?=
 =?iso-2022-jp?B?cWl6UlF0N2dJekFiN3Y3V041TjVObVJRSDNENzd1SWdsc3ZMbGlyRmJI?=
 =?iso-2022-jp?B?N2dJUU5kL1ZnSU1uSzAzVWg2Q0h0ajZLRVZwZkZmOEp0WFlpTGFWNFZF?=
 =?iso-2022-jp?B?aThjMGRvRHlRRHlCT0ZSNlNMNWdzKzY4d3poWkh4UjR6MlhhUGVCOG9N?=
 =?iso-2022-jp?B?blR1MnpNR3p1K0JqaHNiSm1oT3ZRNjhDYjYzREZGVTM3TGNlc3gvU0xx?=
 =?iso-2022-jp?B?Q29YblBURmtycnVrUUhUbkp3YUFBTmM2M1g0UWcrVEl0dEpIVVEwVlZP?=
 =?iso-2022-jp?B?cjNFUnVEWmQrSXBwOUEwd3pwMi9uMVhZSFFnelpQMzBqZ29rVzllK0Jm?=
 =?iso-2022-jp?B?NFkzU0FieC9wWVV2YThYakx2MnBGL1dER3dWa01qLzV5cU5BM2lQWlZJ?=
 =?iso-2022-jp?B?cGFJa2MraDFWOHl6bXBsbTB6SVd5WnI2T0NuVW9mK2txdXorUjhGbjZO?=
 =?iso-2022-jp?B?TmpvbnhSL0QwQU94NTJRQmFLT3ZLS2ZpeGJCNFdnb3VoblZ5aXBDMXhZ?=
 =?iso-2022-jp?B?YjAveXRwTUN3bERIdUJRdllXZytFeGk5RktVeDZiUVc5UVNqTE8wVUhN?=
 =?iso-2022-jp?B?d0FxTjNJQXdRZkFiTm9qR3ROUWdWelpmdnNvdzFRYTNtQmFPZ1B4YzQ4?=
 =?iso-2022-jp?B?b2RKbHI3WVh6NjdxNHZ4NTh4L2tqUElKTm1FaDBlb3M3RFF2MjM2THBL?=
 =?iso-2022-jp?B?L3dDL1VieTJuU3k1TkR2QitZSlZxOENyanV0RnRMQkEydXM2VldxaG5m?=
 =?iso-2022-jp?B?bGt1clR1ak1KWThkMTk1d3FRQ3hrMmJYeFBHUDgyMG1mNUc3a0tqMUsw?=
 =?iso-2022-jp?B?UTVmOXVoOHU1dG9XYXRrRm5acjMzbXgrZlg1OEU0Y3lwRUJKTm0vODg3?=
 =?iso-2022-jp?B?amhJZnJDTHNsVS9wMGNpU1U3RXdVZjVEUHNoQldOajRSNk93WjcrMHgw?=
 =?iso-2022-jp?B?MU81NWxHekJha1Nud1NiUWFWcmZ0Qk1BYkhoQWVUeWJLclJ5ejBMRm50?=
 =?iso-2022-jp?B?M0V1d29IakVjZzViY3htOGxRQlZRMmlHSEdSaHdsNk5sdkxEc0NSeExp?=
 =?iso-2022-jp?B?RXNBV0toaUxpR1JNdHZYY2pyYTQrR1YwOFE3aXpHL21oR1dFczJmbWtU?=
 =?iso-2022-jp?B?dlRTQ0RmamczTjIzeC9IdEFCa1ljUzBObnhYbGg5NXpmalZxSEUrMXNp?=
 =?iso-2022-jp?B?ZkpxdjVCdU9jNzI3UVlpTmJvL1RJdlp1ZkFzU1RQSnJYSmU0TWFkcmxF?=
 =?iso-2022-jp?B?WTNSdHdmcTZITTJPZEJsQVVMeFF4eHBnS0FlTjBoTEVjeXV4azRlbngx?=
 =?iso-2022-jp?B?ZFpmUUR3T0UxY3g4OXl0d1k0WGdRRHplZ29ITWgvVjhvYTJ5dk5Na2o0?=
 =?iso-2022-jp?B?U01zY1hJQVFKV253MEhDSmZQbWExQk5jVC9mMGw4aVFDd0tNWk92dExK?=
 =?iso-2022-jp?B?NUdtSE1Rdk05VUZFdDdSc3NsL1dDK3FNa0dZNjVUSDZRcW8xZ05td05p?=
 =?iso-2022-jp?B?RWdsbTRkc1Y0UGc0MDBkdEZrWW8rZkVQak1ZL0k3elZiLyswY2FLNW5M?=
 =?iso-2022-jp?B?VE0vUUxkTVBVdVFOTnNWaGt3NG5yc2t2WVc2YmZsamRobVFkQ1l5Mld0?=
 =?iso-2022-jp?B?VE5yUWRTMy9kODZwa2NVb25CcnJWc1ltTVBKUVFkdnhuZ1E3L1BTQlBN?=
 =?iso-2022-jp?B?TzFJaHVHR1Q2aklPZVFFbVNQTnhqYzlUQUtxZkRSUlVXc2E0RUM5NWhk?=
 =?iso-2022-jp?B?VGxBajVJQ3VOMGJ4WWtLQnFaM2tKSVM2by80Z2xKTnQ5UXhZY21Lc1Z4?=
 =?iso-2022-jp?B?c0NUdFMxV3o1bElzWE1TcWtWbHIrVU5iWFBNYkZhWTg0OGVaWFMrNndi?=
 =?iso-2022-jp?B?c2FQU3V6ZGJwMkcwaHVwMUFWYmw5V0J2aHBZbTNNTHRHdnR0anBKZXpV?=
 =?iso-2022-jp?B?c2RxMldtejhQNjJJdDBiMGhlYm84SHExSm9qWlJTRFhNUmUvR0pJYWNq?=
 =?iso-2022-jp?B?R2tubHd5dEFzNFVMYjVVRkFUNmRtZFk3UERFb0xYbVBLL2ZyVTlUUEJL?=
 =?iso-2022-jp?B?bnZuS1M5MFBUK1RJTnlwUlVENHpTTmk2eXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde4eb26-86ca-445a-3523-08dc7b2091bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 12:04:59.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daz60onr3pq9QS5t9Psue4BQ2stVL/IyjWWnjTcrV940eIVM99I7qFegGGq63B5OnvfMS6/VLWPknd3/V0Tcy6xXzwboOma5+S1ra1bnhxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8669
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 12:05:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15935

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, May 22, 2024 9:08 AM
>=20
> Hi Chris,
>=20
>=20
>=20
> I made changes in this script to attach a watch job to LAVA job
> https://gitlab.com/cip-playground/cip-core-ci/-
> /blob/toshiba/squad_changes/lava.sh?ref_type=3Dheads#L135
> <https://gitlab.com/cip-playground/cip-core-ci/-
> /blob/toshiba/squad_changes/lava.sh?ref_type=3Dheads#L135> . When I trigg=
er
> this from isar-cip-core, after the LAVA job is submitted successfully, I
> am facing this issue while submitting the watch job ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-
> /jobs/6909129906#L161 <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/jobs/6909129906#L161>
>=20
>=20
>=20
> I am using the right SQUAD token (sorry I initialized it in the script),
_Please_ stop exposing tokens publicly!
I've deleted the tokens in question. You'll need to create new ones[0][1].

[0] https://lava.ciplatform.org/api/tokens/
[1] https://squad.ciplatform.org/_/settings/api-token/

> but still, I am facing this =1B$B!H=1B(B{"detail": "User needs permission=
 to submit
> test jobs."}=1B$B!I=1B(B issue.
Strange. As far as I can tell you should have the permissions you need.
Do you face the same issue if you use the new $CIP_SQUAD_LAB_TOKEN in the i=
sar-cip-core project?

Kind regards, Chris

>=20
>=20
>=20
> Do you have any idea on how to fix this issue ?
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)


