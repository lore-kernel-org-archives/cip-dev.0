Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4169FC19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 07:04:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5578.1741331089623845992
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 23:04:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 52774lBX883106; Fri, 7 Mar 2025 16:04:47 +0900
X-Iguazu-Qid: 2yAbRDIduBQMt7sxqY
X-Iguazu-QSIG: v=2; s=0; t=1741331086; q=2yAbRDIduBQMt7sxqY; m=Zh7ualm1oZwX+ZHFr5FO7WcHkY4kioKhOo51tGkkfaU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 52774jUL3505319
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 16:04:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILwpRL1LHbAhTC+nTBxuFzyOb0BFpWAeUuSP9TQb0NtkB0PIr5zd5bRBJSPLx43bJfN5a0UhUr+OVdetcY75Aaf9ZRrWy5PW6vYD3Ugv5kwmlxWsGyiiPnaEsdo2guRt0M6mX6/hw0vwpTqnDPlM9vG8rR2ei6mZ4+V96iD+dhe1ZvC3aGl18KHC/vbT5SzkDLjqXQ5CowRtfdMd/xxBXjMPfcxIf9uQeMP+dUUvsXnRu2Uu2j7KggbzcbajTLFe59OQ7PPPpl6kj7BJzD6JI6VBe5ATkbtNEn4pNHYfFGLFpJCS0YZaUPdDl3nRI7nXAF2DSGDy1q8KhoOjNcPAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iieS1fDi2r3M5SNxkZFJ/vbsZKJnPWPAvar0+z1HkRo=;
 b=Zrf9+P+PZL4qseuGmcA8Ud/Hspc8qNJMiWl5g1u7FrNb4r7vnoRcnOkzChYjVL8PnNNh0t0XU96fFgxNdQyIkP+j0Z/ieQbxpd+m5PLIzgyp734DzYw8U3IvguocrnZcidcSXjCnGfnZ+0ucXD5QiwLT0S9V7SqcR7GYsNcYQD3Ke68efTSYO3s4DlEv4lh2fjLlwpJexrDvirBncAgn7ovmSaha/umfcwDyxi2e4UMn/lptFDyRNB7HDGsupa7alJlLeuiKGoHT+jRUdWojCFQnWGhtPjwxRqzSCaTsS8ZwrUVdEvsY5KSYP79hAUc6p/j7Z4Q2Zm5tIWK8AZcFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Add trixie OVMF keys for testing 
Thread-Topic: Add trixie OVMF keys for testing 
Thread-Index: AduPKv1Bhwt2OQq0QKq4V/WtZyorng==
Date: Fri, 7 Mar 2025 07:04:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107521441FF10362116BA904C7D52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYCPR01MB9505:EE_
x-ms-office365-filtering-correlation-id: 206bd89b-d998-4393-3213-08dd5d4656a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RndHT1RLSnFPa3JLcklQOFpncGFjSGU5Njh5Wk4zRUdGUDZqODk0UU5z?=
 =?iso-2022-jp?B?aG02MHZLWU1yRWwyUVBjT0JIdnFsNzg4ZzUycHFvRzdIcC9MYlRMZTg1?=
 =?iso-2022-jp?B?V0w5eFQ5Ti9PYlpzOE5pRFFvelFkZTV0RHJ5eGtHREhOeCt6TUpxNW5p?=
 =?iso-2022-jp?B?RWlSUmZZeUdyczlDUXpQc3FPNHJGckNDaE5XUFIrNWZ2Y3ZUOElGRVJ1?=
 =?iso-2022-jp?B?TGd0SHlxYTZNWVRBQmNqWXVYZDdrRnAzOVFWd29QbmF0aVArSnBzVXoz?=
 =?iso-2022-jp?B?OENLK0dZemlOR2VobUMxU2M0eDlORVFNcWIyNHpFUWErY25JUjZ5TnVZ?=
 =?iso-2022-jp?B?VjdQTVV0SElFWC83aHBtSUFSbXBjckVRazFvSStrMHoyR28yRXZkTGVN?=
 =?iso-2022-jp?B?WFZYOVZxWVJOVUFqK1BWalBqb0tiWFcxeWVmMHFPbG11Q3hlSks2OVE2?=
 =?iso-2022-jp?B?R2YxTEhwcHhsZ2RHbm1hbG1XMkx0bzR6TjFST1FRNFpqYnZFdnlHL2Vz?=
 =?iso-2022-jp?B?M3F2WVZsY2tqUkVLMWNpNGpMWERndkJka0ZnOGhXME5jK29WWEJ4YmhV?=
 =?iso-2022-jp?B?YVFvRy9WYm0vanRueEVRYU54OExzQmg0VlYwL1JwTFVJdUN6cCtWS0Np?=
 =?iso-2022-jp?B?S0FXaEhYR2FBRTF6Zy90ZDFobmxrYmxsOVdmelVpc1RkMUNiNkM3L0ND?=
 =?iso-2022-jp?B?OVBKRUhMVDJtNkpCcnNURzBOUUs5VTA4NUFENFFzeVpoYkJ4U3RtL3Q1?=
 =?iso-2022-jp?B?QkYrSnhtMlV3TEl0SjNpdm0vMGNta3M4eHFwMmgyYUVxazZ0cnRvSlRV?=
 =?iso-2022-jp?B?SFZHWGRyWW5WYzZaOGFCalp4V0htZDdxcG0xa25LbGQ2b3hZS0FJTTQv?=
 =?iso-2022-jp?B?ZHBiZkV6bEtPOGxLYlZFNlBpN0ZlbE0yR0RWekpobGtyTHZZOUR3MzlM?=
 =?iso-2022-jp?B?TTQrQjZNNm5hbGdIelhRbWtHWmljNTVhRkIzMmcyWWpXYjI2R2xpSGVz?=
 =?iso-2022-jp?B?ZUV3QzdjQ1VpNk1SSHFhQ0RRNlJjUjEwNlVudWNxa2xXS2FGVVc0V0Q0?=
 =?iso-2022-jp?B?ays4RVRKck1obElSMVZwd1Arb00wTkIvZnZ5bUZPQmFWSXVUZDJnTGNk?=
 =?iso-2022-jp?B?c0thTHNGMFNzMUNuZW5yNTNuZDBLWEhYYnFIaTd1TVd0N2M3UjNkZ2ZY?=
 =?iso-2022-jp?B?OTdIV21lWUtKMHNHV2JFV3RCQVBIQlh0bzFVVkVBbzlqR3grWlZEV3JU?=
 =?iso-2022-jp?B?Sm9MVEFXV3NWdENsbXpiT21FeFA5SUtqTVMzL0d3MnJld3NjaTVPcjVk?=
 =?iso-2022-jp?B?akxMWUxlMVVxRUVQY3dLTHJKTW5PaFRkNmQrcy8vcC95R2RSMk1maTJJ?=
 =?iso-2022-jp?B?V0F6K2YyMjBRM0JkZE5SdWh2ZHdvbElsU1UveGZTeWt3K0ZiOEZIaDlV?=
 =?iso-2022-jp?B?TVNUTTJBMlBhSFpMZmR6S0hFSURncUlBdm8wMkhyT091NHkwdzRkcXd5?=
 =?iso-2022-jp?B?dHIvVUZPNlRsalB6S2M4cFNQdVA5SCtGQTlvK1BiNXZpeWRkV0RaQ0Fz?=
 =?iso-2022-jp?B?TXI3NUJtcG12Zk4zc092OXc1ak51enNXKzBMS3FVSXVqSXI4YXpMWkwr?=
 =?iso-2022-jp?B?UDY3cVJhK3A4T0NEOXY0aUJqNFY4Z05pdWd1NjRoVkZHMFZPa2prbVRW?=
 =?iso-2022-jp?B?Vm9xTmgvVFZOUVFlVVJIQXVaNEpGN212cEFnYytnL2FSTDBMRjBBdXJk?=
 =?iso-2022-jp?B?QlZ2dlZjT0d0SXM2am1LanlLNzJTUnBIYnpoUHh5Nkx5Qll4THp1M2sv?=
 =?iso-2022-jp?B?RjhFNkdKdGw5anlnaE9neE1UaHJzd0VJL29MNUZmUVBSbEFRZVlubTlZ?=
 =?iso-2022-jp?B?dGYrWXBQdlhOODhUMjhGVzMrcDV2UHVzSjJXa1Z2b1NJbGlsSjdOQnlO?=
 =?iso-2022-jp?B?d0h2a1E5bW5CY0w2MDJ4OHVVcUU4anBkSlp6L3FpaEtjY08zWUx1ZlhS?=
 =?iso-2022-jp?B?TW16R2hQOThzdU5TTG5CU2xKS2xDRVFBK2VsZWViakhXUHdjZzNGWmsy?=
 =?iso-2022-jp?B?b1h4aHJYRFpuRUF4VmRsWElHb29CcEZNcFBDSjBDSnZQQVVKVzZQZXd0?=
 =?iso-2022-jp?B?eXY=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ekRjdG9wS1p1THFoU1ZzbTVod1JNbjZPTUNNSEZBV3pDL0lqT1hhb1Jj?=
 =?iso-2022-jp?B?d0orR1NEaXpNWmR5U0taODdGS3lCa1BabVBaY09uRHM3OTRCcklHU3lt?=
 =?iso-2022-jp?B?cTFzeTBUTWQ5RjBocXJhRTBsUkxDSnVaaXN5bXZxVy9jaDhBNHh4VGpm?=
 =?iso-2022-jp?B?bHF0cVNGczU3VHl5U0tIRFZMUkJaMGJiRWtBbmhHYWRmTUs3YjJtcmw2?=
 =?iso-2022-jp?B?UWJ2UnlsanR3aWJDWmJXNldQUCtRdVdRL0RubllvSG5GYS8rejh2VUFC?=
 =?iso-2022-jp?B?c2pHZmFZU3RaemQxbCs5Wnh0S2hFUjRqaXhGbU9iaTc0NEdmMEUreC9j?=
 =?iso-2022-jp?B?QnBidlRwY2VacXBraXM1ZjRHWFJISUpYbkFmUGRZQ2t0RzlhelJYUXAz?=
 =?iso-2022-jp?B?UUYveE1vemJ3YmR5bWZQRVF4dmpsSEI2YXE3cnVBZUgrNDFFRThyVXFt?=
 =?iso-2022-jp?B?d2RJNUdITG5wejhRYU1GbmhoSTUrNTE0ZmIwZ0NxaWJlRjlRbXJvelBB?=
 =?iso-2022-jp?B?eU1sb3BOZlROUGhYNmRhdTNHS0JNSDllRmkzN1VjOG5LeXNRalFFRFFq?=
 =?iso-2022-jp?B?S1pIYjRMOERQRFBOc2MrNHJ4TEJqUGZtbWRsejRTSHZ5dmpGUWJiOXc3?=
 =?iso-2022-jp?B?cm8xamtMaE9DdGdrR1lCak5janZMeDdud2QyZjBnYUVLc01UaFVzZDh0?=
 =?iso-2022-jp?B?YlMwMjVlbzVZOFc3eTdOWkxXRGR2MmpnT1ZxMEtHQzN3Sk9LbVY4aVRP?=
 =?iso-2022-jp?B?Nmo2eGNTSDFNYUtqWGF2TklJVDZKc3Rqem55aURXUjZjRmo1aWU1ZVBT?=
 =?iso-2022-jp?B?b1VCRHRxWnd1WHRVV0dnZnpIZkhBWlh5dVNjTzM0STVMNWtGN2h2aWNU?=
 =?iso-2022-jp?B?dGx3Z0hsaG5ZRjZBWFJSdFBXb1NyaEgxWTlQdHBhbVVMdTdGMVZmRlEw?=
 =?iso-2022-jp?B?SGU2MVBmZXByUlcyR0kxWmhoWUxFU0EyQkx1cGhHV2RaTUcrekwySkM3?=
 =?iso-2022-jp?B?R2NxQU5NSjBqZVdDeC9Id0pIdWI3VEVnRGZsbFFDRE5MNTUvbHo3UUxQ?=
 =?iso-2022-jp?B?U2RXRlh4OFZyR1dIcjJ1RVhxdUlZUkQ3UmttbnVTc2dJd3o3U1B4UnF1?=
 =?iso-2022-jp?B?UHliaU0ybXlya0tOKzgyUUJraW9kemRld2M1aTR2L3B1cEcwNWtHYW5D?=
 =?iso-2022-jp?B?L0xYc1ZDOWhpQ1dOQnRlWGdab2tPTjJWNzdNZFl1QnJieWFSZk00UEVU?=
 =?iso-2022-jp?B?T2dNU29NT0hhc1Bub2s0d2hJdXF6OHVzZHBsODRjbEdDZFRrMDFmWUg4?=
 =?iso-2022-jp?B?YW0xSkgyVFlKWHRsdjJCR0FaVTB2SHJnM2oxM1N3aEQ0c2lJSmxrV3Jq?=
 =?iso-2022-jp?B?dVhML0t4U1FxK0JGT2JyaTNVTVBXS2FUU2xtMDFHLytDSG1FK1NQZkkw?=
 =?iso-2022-jp?B?cFN0OHBxOEoyeWpDUjV1anBkd3J0VTVKUm03WkZKQWJvR3lQOGhTRW1K?=
 =?iso-2022-jp?B?VHJQNFRyVTJrMEo5eXEyc2hqYUNWaWJLcmtKN1E2T01pTVpIandKN25C?=
 =?iso-2022-jp?B?OW5aVEVsQ2pQdis2azcyOEJ4dlYxb1c3REJnV25ZdVQwdzlCKzhaQWtQ?=
 =?iso-2022-jp?B?K3JRMkZqdFNsMjRpSElsWGpoajhnY1MvVjhTczZYSndDU213VWYvd1E5?=
 =?iso-2022-jp?B?cnFWTXoxaEZpcFNSMXg1Q1prT2cra0lJcDNEbXlZQ0NYZzRUZVM5QXh5?=
 =?iso-2022-jp?B?WEp5SWJkS3pDMEpnTUFMYTMzY2J1SDd3cm50ZEFWckRoYnlxM1VkS3JE?=
 =?iso-2022-jp?B?MFhTWmRySkRxWXBIaW9LYzFDdEFHa3h4UWRtZzNxVnhtakl6SlYvRnJB?=
 =?iso-2022-jp?B?VCs3NU1Mb2xpcnUwRk8rYWJqVDZDQ1JtSjc3aXNQZ3E0YlkvK1lwSWxQ?=
 =?iso-2022-jp?B?Q1VXREdqbE1vdm9SbzNNTHI3bHJXb0w3MEN2N0djdy9vby9idEtwdnlt?=
 =?iso-2022-jp?B?RkhoRkRXY0pSZnVSN2ZQTGRiM1FNd05sV3dUS1lmeHd1eE9oaUhPZmRO?=
 =?iso-2022-jp?B?ZTd6MDRYY1BpWWVOZ1pJQlVpVkpxSG5OS3BGWGJoVWs5OUp5SWpMMDJC?=
 =?iso-2022-jp?B?WVZOa2Q2eTk2RlhBd1JRKzhPNHV5Nko0SXIzUjRqdlU4UFZ6WlkySTZa?=
 =?iso-2022-jp?B?ejMxWXBBcUY5S1o0SjU5b1NmMVBwOEc3ckY4bW10M0xRMlFsNXdGc2lC?=
 =?iso-2022-jp?B?ZU16aEx4eVpDSEM2WW5ya3V0Rm9xYTZBclZkTjgyVmVPVGdSSnZIMCt2?=
 =?iso-2022-jp?B?T291aGpTekFPcWFoU3kxakc3ZnBBRVplSGlRZjhDZ0FzeWdXREtyMlhE?=
 =?iso-2022-jp?B?a2hrZkU9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB1107521441FF10362116BA904C7D52TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206bd89b-d998-4393-3213-08dd5d4656a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 07:04:43.8655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qV8xv0QLqL1FdV1S2Vw87r61ImFlkDhBwSTEJpHPxLA3ZJGDSZ8IwyR8PZhf8kszr5wpQQ2oI3cX5Wwg72PTu3OB7TqBNt1zh2uM7wMPskG1LpnJjirmh6Lqdf0YmGmd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9505
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 07:04:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18066

--_000_TY3PR01MB1107521441FF10362116BA904C7D52TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Dear Chris,

I hope you are doing good.

This is regarding the improve test coverage for swupdate and secure boot ac=
tivity[1].
We have a scenario where we need to verify the secure boot with mismatched =
keys, for this we plan to use trixie version of OVMF keys to verify the boo=
kworm secure boot image.
It is working locally and throwing an error =1B$B!H=1B(BAccess denied=1B$B!=
I=1B(B as expected.

So, it would be better if we add trixie OVMF keys in any one of the lava sl=
ave machine for this test scenario. We can use tag option to force the job =
the to use the specific lava slave machine for this purpose.

And also the zchunk based swupdate is only supported in trixie version as o=
f now so, in order to verify zchunk based swupdate on amd64, the trixie OVM=
F keys needs to be present in the lava slave machine.

If we add trixie OVMF keys to any one of the lava slave machine that device=
 can be used for these two scenarios. What do you think ?
Please let me know if you have any other idea.

Please note that we don=1B$B!G=1B(Bt need install trixie version of OVMF pa=
ckage, just adding below two files in slave machine is sufficient.
OVMF_CODE_4M.snakeoil.fd
OVMF_VARS_4M.snakeoil.fd

If this approach is okay then I will send these files in email.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120

Thanks  & Regards
Shivanand K

--_000_TY3PR01MB1107521441FF10362116BA904C7D52TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Dear Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I hope you are doing good. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding the improve test coverage for swup=
date and secure boot activity[1].
<o:p></o:p></p>
<p class=3D"MsoNormal">We have a scenario where we need to verify the secur=
e boot with mismatched keys, for this we plan to use trixie version of OVMF=
 keys to verify the bookworm secure boot image.
<o:p></o:p></p>
<p class=3D"MsoNormal">It is working locally and throwing an error =1B$B!H=
=1B(BAccess denied=1B$B!I=1B(B as expected.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So, it would be better if we add trixie OVMF keys in=
 any one of the lava slave machine for this test scenario. We can use tag o=
ption to force the job the to use the specific lava slave machine for this =
purpose.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">And also the zchunk based swupdate is only supported=
 in trixie version as of now so, in order to verify zchunk based swupdate o=
n amd64, the trixie OVMF keys needs to be present in the lava slave machine=
.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If we add trixie OVMF keys to any one of the lava sl=
ave machine that device can be used for these two scenarios. What do you th=
ink ?<o:p></o:p></p>
<p class=3D"MsoNormal">Please let me know if you have any other idea. <o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please note that we don=1B$B!G=1B(Bt need install tr=
ixie version of OVMF package, just adding below two files in slave machine =
is sufficient. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">OVMF_CODE_4M.snakeoil.fd<o:p></o:p></p>
<p class=3D"MsoNormal">OVMF_VARS_4M.snakeoil.fd<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If this approach is okay then I will send these file=
s in email.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/issues/120">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120</a> <o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks&nbsp; &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K <o:p></o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB1107521441FF10362116BA904C7D52TY3PR01MB11075jp_--


