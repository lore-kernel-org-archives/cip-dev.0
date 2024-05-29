Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BE1C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:59:48 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.46])
 by mx.groups.io with SMTP id smtpd.web11.9221.1716973179586151159
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=AItY1P6a;
 spf=pass (domain: renesas.com, ip: 40.107.113.46, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDVKU0LmagnAKzpm/KUrhyhUOs3K8u/z0Wt38iyo81QGRb2aUvmWfaaFSRL+qYsHeubXEKaIEA27hwczJFoz6gdtR0SPa2t4+WwaXx47s1Y9gKFmpk/UCJW8PQBd2lvvVtbLLvfKguXwcBBfmtI3QxijeYVTohKkDZpW8geRENjM0qFcf9ZDrw3qfwS2u9ygKRqimEbevNDVjF9qZWmSRExPaudPmE1PzxXf7rmLCPoKryyuTq6YGMJUz5esJzL+qs7/ZuZJ8FBs3gWEKn+fKwrJEHns1VzDtYGzYfTTK+qMb6lY3TVb9yHHqi8tp9dYWDpXr8wb4q4cPX/jkvt/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhHftvOwdrPLjQeuexdXTTsMW1uHKRuf/VhxfehlBws=;
 b=JxfhV/84HilGh3Dd0L7PlAd2wIGzzQB01UjxI7riDPgtfmhRgMDkU/CJ2RGcP1noJ0po8CCOhsylfeh1t+SlcpGh8AXV7J1BaMJrjVA9F8t9QZH0+gvuCKhzQTrdN4fpfIUyFr7oRGmuBKc5l6lSC94NFxtjzxKAT9Z3ZAelYlLOCJduMMkw+i+WiE2gSW5aMOuZaELk9CYPtNKY7W/EfemcKoPicd9QEYJg40UShaTVVdsDnsDxqIlqBU16wEpZRgsZVdzqNaMBqGewCx8Fzb/hh2jPn8bLTPb1860HaYdaKQqwecU2/DA0WfcHyU2KyDnVLifXQUQv43u8SYaWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhHftvOwdrPLjQeuexdXTTsMW1uHKRuf/VhxfehlBws=;
 b=AItY1P6a18XrI/HVhlJKpblKXlHu9uSOH0DWoQOy0bnWfiJu6oY8umRo/Rs1me+CkQAbe+L88Au01z3NJFiFJrHhxL9qljcoAPo91nWRkqoA8PdjES5yKjZq/N3d/BhK8T6XtYupOEnPjJLHgLLfVcIxzxQvln5q/klEVZSmZ/U=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYAPR01MB6459.jpnprd01.prod.outlook.com (2603:1096:400:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 08:59:36 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 08:59:35 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Unable to start swtpm_start.sh
Thread-Topic: Unable to start swtpm_start.sh
Thread-Index: AdqxZjRcYVHYPZxaT7+kSAcinUMJhgAQCb5g
Date: Wed, 29 May 2024 08:59:35 +0000
Message-ID: 
 <TYWPR01MB118625C09DB4B02CD05FF2A75B7F22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB610382522DF0932C7EB0CEB6C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB610382522DF0932C7EB0CEB6C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYAPR01MB6459:EE_
x-ms-office365-filtering-correlation-id: 4d7058e8-e679-4b73-4111-08dc7fbdaa20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VGJIQlJ3VnJKTzBLbzN1enJWNmV1ZUFOUG9QUk9ZVTZaQ09yeFkvRzBp?=
 =?iso-2022-jp?B?SHNaMUpaMVJGMU53VXV1c2l1UVA2Z3ZKQnV0NjUrSTc2UlpIZmlnakRV?=
 =?iso-2022-jp?B?TUdUbXd2REtBMGVqSFNXS1plR1pnYkNvN09IQm9Fd3hVUGY5UjVxV25y?=
 =?iso-2022-jp?B?KzVSTStFaFUrNlU0dStWenlDWmtqV0R2Wi9adG5uRmRMWFA1TDlWL2Ev?=
 =?iso-2022-jp?B?UzJCdDVkK0tDWktlQjNlNTB5WWRmRkQxM3EzTlB2VGJxOVF2TU0wbVIz?=
 =?iso-2022-jp?B?dURFMC9MUXVFWHNBUmkybVowcEp3NWZwYzIwdjVOc1JvaGFsemlyZzNQ?=
 =?iso-2022-jp?B?VXdHYUpoRmd5aVNoT3pXRWwwUThsRUoyNExvVFlIdmYwUkprNjhDODVo?=
 =?iso-2022-jp?B?SzJhM01hZlpoZmVReXBoRlE2Sll2K0VSQktUQ3pPbWhrQzlrZ1crQzRK?=
 =?iso-2022-jp?B?ZU05OHFaR2FEQVg4MFdZdVp2aWROVFQ2U0ZZZStOdHdsUUlNdzFUamhp?=
 =?iso-2022-jp?B?S0VNMXdVenNFTXk4MjFkUElSRkx5c1dRQ2c3a3R1NUt0ZW1QZTZvSW1r?=
 =?iso-2022-jp?B?V1ljWlpnL2c4elhKZ0cyQlFOaVd5U1p5U3hIMUFIcklyL1JCVzFvcXhI?=
 =?iso-2022-jp?B?cThpZDZlVWVHVXlMSkFhdEUvNDdMbnhsTE9KbzJySGNMZUZDaW9GRnVZ?=
 =?iso-2022-jp?B?NjV4b2JFYmRWWE1MUEpLSk5CU3h0bGgyVElscGo4MFNKVzhJb3ZNTUFw?=
 =?iso-2022-jp?B?VWNyN1NlQ1lxSnk0a0dUcDU0ckw1a3hHYkRLVWFQYzBMVVJocFJxSzZ1?=
 =?iso-2022-jp?B?TGwvT2JzeEhWTGgxSG5VdXc0TUJuQUhvbWF2eWwraGNlQVBJVkdyT3cy?=
 =?iso-2022-jp?B?ek9PT0oyeVR0amhJUVArR0V2Y2lOTEZDNjdSYXJNOEpueXV2NlV4QlRR?=
 =?iso-2022-jp?B?OXlDYSszazBHT3huQ3hxdUI3M3kvSUJoMHFQU1BOcEY5Mkk0dGl5alp6?=
 =?iso-2022-jp?B?bk5vRFRyTnc3SlQ2SEpmV2FNMHl6QzBQUllDb0JQRUxQTTZqb0c5Kzdu?=
 =?iso-2022-jp?B?V3hWbGFtODRYMkhzV0R3STJNS054Z0pmbzFtTFNtdGtjTkFVU3N0RUFa?=
 =?iso-2022-jp?B?Z0JQMmtKajNFTjd2Nml1aUF1dHQrbzV1NTk4U1RxWWl5dUx5dXAwa3hq?=
 =?iso-2022-jp?B?cUNqdUN5OHIxelN6VmdmSjVCdFJqTnJpdGtKN3oyRjd4Z2VoaktEYnlZ?=
 =?iso-2022-jp?B?KzE1SUxkRFAzZTdHN3F1OXFiRnp5dVRtUHRMeUoyWDJ1NjJaQjkvQVRU?=
 =?iso-2022-jp?B?SU81S3BOSFBobHptVG9tcjVXUE91THJlSWpuT3BvYmxCYm83YWZMZWEv?=
 =?iso-2022-jp?B?K1crZHMxOGJMS3V3MUtvMm9iMWNOODI4U2l1eXZoWm50dTNPYW9RYUoy?=
 =?iso-2022-jp?B?TUJDa0VCdWJTM2wyaXRhMFRlaGZ3NlE5dUV4eDVzZklvdzJEeFhMN0o3?=
 =?iso-2022-jp?B?L2FzdWdoWm9tcEJSQlR4d1BXS05lM3UrUjV4Mlk4Q09WbzYyTlRMc2Nr?=
 =?iso-2022-jp?B?a282NUh6QXBJTUxZbjV5ZDBPTEtIWU0vVk02Z3J2TkFtcXJpNUJhdnZ5?=
 =?iso-2022-jp?B?cXBMWWVSbGZXa1hYZTRxZ0Q5Wk9jMjBWamZUdnRqV2JOa3JiUVE1Y1Ir?=
 =?iso-2022-jp?B?ckd6VXRadFF2RUgwSS9DRkZHRWp5V3RlWEtKTnozTXlLdEdDRElqVmw5?=
 =?iso-2022-jp?B?SDBjYmJOVDYxaytNbjdMNkR3aFZtUmpoYUFBbU16RjhUVEhaMUJCeno1?=
 =?iso-2022-jp?B?V01tOTlqVlYyK0YrMEpTc01ObUN5WmtONHlWTkdML1FZcjY5MmVoaS9n?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUQxajNmSHNPZDJBSllwa1pBSkszRXBERXIzWnVlc0tzZ2RWby9ZZy9O?=
 =?iso-2022-jp?B?T1pscVdGbDQ0MHhPVFF2eVQ0emtJcGwzakp2T0lxdnYwY0hYLy9ESzlw?=
 =?iso-2022-jp?B?NlhKMVN5T2M4REJ6ZjJYMXZveE01cDBPUUVXNGdpNXFWcWhxMERLek1l?=
 =?iso-2022-jp?B?VUxqY1hqeUoxUWZuSlZ1UTRjTU9iaTZRcDhhMzRsSGlvUUtTZzBVa2hy?=
 =?iso-2022-jp?B?WitrN2p4eGFsd0FhRGQvc2tIT1hFVm5Qd1ZoMlJjbXJ1TFlwK29jNnAv?=
 =?iso-2022-jp?B?TFZrbUxpRVBEZ1hLYXJ1aW5lb2Mrck55YmJzdmVWakY5d2VQMGg1dEpi?=
 =?iso-2022-jp?B?emVtMmJWdE91TW1vZVlJQ2hjSm5BNUtRNEZoOGkzQUZ5RXczdm8vbDRB?=
 =?iso-2022-jp?B?c1V5N0ZHTEQzbzUyclIwb1JCbUNMMklncTVIN2hDakFVcVArakloNmZn?=
 =?iso-2022-jp?B?NURmUFZ0MVI1YVlROVg5NldabG1pUzZhYm1ZK3JLaC9WUGtPaDJrblhv?=
 =?iso-2022-jp?B?N2NNWTVyOGlRTjEwNUE1clhHVm1lbTFJMUdQWVBSWldJNUl1d3BoU1Qy?=
 =?iso-2022-jp?B?bktrbk5BaTdYS2dDcU1WY1BaSmFWVFpuN0ZabmpWNXlCSmJBaW9JSXB4?=
 =?iso-2022-jp?B?aGRRQUdsdkVpcmlrU2ZvQjVVNWwxSDZRbXB2RWdDSG1MWHRIWXJJMnVJ?=
 =?iso-2022-jp?B?ZWdpeHdrb0tpT1FOVHQ0VGlFcTM3ZlI3VjdpQVhKd3h3UGkyekJycmVX?=
 =?iso-2022-jp?B?UktFQ2x3cUlrb2xrNC9MdDdaYWhsaHkrOGg4bDhpUENPY0VXSHh5UEpH?=
 =?iso-2022-jp?B?Z3p3ZTNWTkhzcTgwekxnMUFXWmFnYUpsR3NhNXJTM1JuVU1NdDQ1Tkw0?=
 =?iso-2022-jp?B?ZU91UTA3LzBIM2NYR090Y1ptdXFyNUlTeDMyNmltNGlIZ0RPWFZCZEpl?=
 =?iso-2022-jp?B?Y3dmYURZVXRwODRBR0pOQlhET0FuR0JlSWRvZW1qeW1Kc0pNcE5PbkIx?=
 =?iso-2022-jp?B?Q3VuNG1DODNPUS9LQ2dzazh0OURVT0pOOTU3Rmh1aytMb005c25QSk1X?=
 =?iso-2022-jp?B?NmZkUzBWb21ScGxYRmZlV21rMzlSaWdJc1hJaFFXemNOVFM5T3dOMTcz?=
 =?iso-2022-jp?B?WmNSL0hVMnBHQW1PbnhkQjlyazNIaS9QVFlNeFJzMFMzSVZyeU1CN2VW?=
 =?iso-2022-jp?B?UlI0SVdManc2MzVKZnV0TTU5dUdpMCttZWlXdUxrc1A1L0ZXK2ZFd3FV?=
 =?iso-2022-jp?B?ZGRIaXkzMEhSRkgzUk1YeUk1TXNiMkw1QTlnaWtPaHhmY1R6RDZ2YU9R?=
 =?iso-2022-jp?B?YTZvc3R2K0hkZUpIU0N1ZE9VcTFGMVJGdDBOYzlQRVZVeHpNQTJscEp4?=
 =?iso-2022-jp?B?S3haQjEzc2VEWGhpTVlVWGhQZUl2c3BqTGFLUjcrSzFKRDFKV1VCSUcr?=
 =?iso-2022-jp?B?Wnc3MTloOU10Mkw1WDlsZkUzU2g2MERpMXNMc3UyTDJqbUoxZTVZckJw?=
 =?iso-2022-jp?B?MWlkR3hXSWhET1JDM3NiT1VPSEs0NGx2WHFBSkFyN1V3L28zdm9COFdG?=
 =?iso-2022-jp?B?eE5FUHJuZWVuSHQzbXNYcGJQeUxGV1dadVFsTjZXSjlSeTBKWWpJd013?=
 =?iso-2022-jp?B?NzBaU1c1TEp3WHhkM05OUGQyUFowNDNRMzE0WDdNWVJlUCtTTUt4WnZh?=
 =?iso-2022-jp?B?QTIycUhVbkJTaTlNd0JyTTJ4ZUZBMmNPVXowMUlnREUzT2Iza0lVbkRy?=
 =?iso-2022-jp?B?TUpKenNyeEJiR2N0bHViSVQ0ejJ3UnRMR250NFE5ZEZSekxmMGRFWHI2?=
 =?iso-2022-jp?B?MU1KRmpHSkdyQmJSR25kcTRFREJ4aWw4YVRGSVg3M3JNM0VkMlJJMVVj?=
 =?iso-2022-jp?B?SEZZd2ZSWXQ4YThKc0ZqTVV4dURGTElSUXhkM0JhR0NHUjZQUGRNa0dt?=
 =?iso-2022-jp?B?djFKT0pDMmFabHlZOHRxazJrMjJ2WHNXeVZFT3dDdVJ6RGdmaVQyT0NV?=
 =?iso-2022-jp?B?M0ljSVN4ajZoY2JiWHQreE1pcGJJUXIxS2daZm1NNy9qMEh3YUF1M3Ry?=
 =?iso-2022-jp?B?VTZ6RXdOeHZmWjUzcE1wQzVDamNNa1dONHNlbnFFVVZGK2loNVpXOVR5?=
 =?iso-2022-jp?B?UURRMXpQbUFOUTRneWJySktYa2JqeE9XY1Zuejg4Tng1Z01HbndtemNa?=
 =?iso-2022-jp?B?ZjREWWlpV0k2TEZmWnBpYmFTd2hxa1VYOTJybkNkbDZQRmE5SDExczhx?=
 =?iso-2022-jp?B?K3NQZDB1TmRyVWxNcDRRQXpWT2hHY1lpa09mem1nQUFSbHhEZHFBbDBl?=
 =?iso-2022-jp?B?MVhDeDV3Y1R5YzJBdXgxSERjMWhmbFc3NkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7058e8-e679-4b73-4111-08dc7fbdaa20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 08:59:35.9136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0Z3kKSuksBckOXtkXRJekDPiOVMBoFdWnJ+tMhxKoXlE1q8znV17UXzgM79QWcb5VfTI1pVe8ZpKmG7Wo2swxRb6TcHONSXc+aOgU7UVXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16062

Hi Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, May 29, 2024 2:29 AM
>=20
> Hi Chris,
>=20
>=20
>=20
> After the scripts were included and device dictionary changes were made t=
o
> qemu-renesas-01 and qemu-patersonc-01. I tried to run the jobs, but
> swtpm_start.sh  is unable to return 0 as it was doing previously which is
> making the job get stuck until time out. LAVA | Scheduler | Jobs | 113979=
4
> (ciplatform.org) <https://lava.ciplatform.org/scheduler/job/1139794>  .
>=20
>=20
>=20
> In the end it is also mentioning that it is an infrastructure error and t=
o
> report it to LAVA admins. For comparison here is a successful job which
> ran recently on qemu-renesas-01 with your manual changes. -> LAVA |
> Scheduler | Jobs | 1132059 (ciplatform.org)
> <https://lava.ciplatform.org/scheduler/job/1132059>  .  Previously in you=
r
> manual changes to Renesas slave, there used to =1B$B!H=1B(Becho $?=1B$B!I=
=1B(B instead of return
> 0 here https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-
> lava-docker/lava-slave/scripts/swtpm_start.sh#L18 <https://gitlab.com/cip=
-
> project/cip-testing/lava-docker/-/blob/cip-lava-docker/lava-
> slave/scripts/swtpm_start.sh#L18>  which made swtpm start successfully bu=
t
> that should not make any difference, right ?

So the script works as expected in your local environment, but not in LAVA?
I'm not sure why this would be the case TBH.
I'll have to do some debugging.

Chris


