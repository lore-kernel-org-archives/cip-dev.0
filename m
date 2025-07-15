Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C937C83F1D
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 10:53:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5348.1752576825071049138
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 03:53:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56FArgSb843995; Tue, 15 Jul 2025 19:53:42 +0900
X-Iguazu-Qid: 2yAbuzQy509uHjv769
X-Iguazu-QSIG: v=2; s=0; t=1752576821; q=2yAbuzQy509uHjv769; m=bsNcB7MFSUqvU1HDw3G8DWUvMwjAJ67hWcs9fp5Yb2Y=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 56FArerP3453304
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 19:53:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVKiKtyJfF70nAut2PGH9cJAoSghLGe7fesUEp0k+7r87gRIqOYg+wshZqJz+nW0yLHrmuosp05OZS+47wVbZwHkY7YkEqRVL3eC8FcBIofZw3qlSBTDw8ZYZAxz6DGd9HzviwMNq0+ViqJiQQK2ZDoQh1o2vHywHLIRnxT81AsANbDAs4HC3G17y4bo6ZJs2Va84KJr/GlcD4XJZePlq1C+izYFng+2DuVB6W99wluKi+pxqwSXb15EN3bqdiOatNb57GIFzFwqzvdlJbwTimqqcK0lCC/oU/mN3kh2ixIKyM5IOjsQJcIJ6kCtojbEP0mACw4rjUohbjsU60CjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvAbU/iTAnM6fEIjWgBjl9I8gnm3yoM/akK9863vvZE=;
 b=S0eblOvoBlorZoEGqqs9SLxV+PUSio8FFZ4Fh2GfTWiSPA45A/yoCN8JqzqbQNTndxHWm6r7voZgM+XHD9pmV4WaMZHnnGl2tB5zlLDpzmypE8xcQSyu9zKjg28mvcN8uD763gHVXHCleTZZQ+6OpsYS2lt3M6Pu9eiXA8NZGKK9oQatt2IjWXLqlSS2Gt2+T+uQ0UCsScscpIrKR7V7ekqj3bOeFo/j5bS5LNiq9NVQkSyYDYtmD4kjUMOmunEGBtw+RAYVfg57PYB9BsNZxMeg/nQ3gjFcQ0fQAEWM2xgYnmcwYGTyAPR5QksDcxgEwUSNHQwSyLlljBo8GHYUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Topic: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
Thread-Index: 
 AdvrHhlzn/A/DOQaQCWzDQhadgxFugAAWvSAAAJFldAAAq2dgAAAqsrwAADXmQAAADm2oAKFRenwAAfGywAAAHnW4A==
Date: Tue, 15 Jul 2025 10:53:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107546DA13B576633ABC1614C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <643a6b8c-feb3-4b27-8fe6-f76a30ce0a3d@siemens.com>
In-Reply-To: <643a6b8c-feb3-4b27-8fe6-f76a30ce0a3d@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS0PR01MB5668:EE_
x-ms-office365-filtering-correlation-id: 06fe4064-aaa4-4f18-f36e-08ddc38ddad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UHJ0a2diTzFxcVJOZFVsQi9nOUptcFNnQWoxalNvK3liNzFjVS9kQVpNY3cx?=
 =?utf-8?B?VUZyVHZWWGd1TVdrMnpHVlg5endTa1JRRklXZ2IvYXF6ZmZ2U0FMNmJCRlAz?=
 =?utf-8?B?UGNHQnlEMGduMVpMZElibFdDdm1jclExUUx5UW9hMVJWSG8yVWYyZTdZdVpQ?=
 =?utf-8?B?U0JiZ2pST290bWhhRHU2YVZReWlpeXVzdTZ0QXVIcnluRG8zS3VuQTcxQW40?=
 =?utf-8?B?bkI2cmV5SjJ5RzZxdytvNGdIc1lBekN1S0tzR1UrOTIvN3lqSXQ5VXdiUWgr?=
 =?utf-8?B?U3hUV2hLa08rMDg3OHFHOW5pV3FFakJWYjZLRUhIU1JQYkZEWVAxbHNqbkRo?=
 =?utf-8?B?R1N4Q3BhVFFlVm5iNThXeTV3Z1hvaFhwdzVyU3BaVTJFamhlWVRZQ0dic1Bu?=
 =?utf-8?B?WHdVa3pmcTcwUUFxUVZmLzNZbEFoQVdTVnVzQWxydEt1TTdiVFhLdlR0MjN1?=
 =?utf-8?B?amcvTUdTaGxveHVvZk9vSzU4SUxFeE0yczNxazh1WTZIbFNDVmxVL1B2Nmsz?=
 =?utf-8?B?QVljdXhUNmZFdmxqeWlwQTh5NnJ2V2JkNG9mNWZPQWh4TGZTOXE4REhWbHFT?=
 =?utf-8?B?YkY3MEIwV3hnOEVXS1laakk0clFBRWh3TXEyVDF3aGZ6WFJjdHMyako4aVFm?=
 =?utf-8?B?eDR3NjdZYWt6dGpoWTFWZTdaQ1NBdm1WR0xTdEM5SGY2SVY2di9nTHphRGxP?=
 =?utf-8?B?andjQkt4YnlpN3ovTUJoMlZ2SlpsQytyL3UxeDRPbjYrazF6TWVxTjljT2xF?=
 =?utf-8?B?TTN3UndjQXczTXdOQkQwbEtMdTFEVW04VDRjN1RjZmxCRHBVK281eEp3UGxM?=
 =?utf-8?B?UkcxK1hud2JOd3dLdlYrUUt0cTZZVFdqY2J5VTR0TkZZU09oZ1NDSmJCNUx4?=
 =?utf-8?B?WXRWcFhUZlMydXlmNkVqbUhLS3RaVHZxcnNUTW9CU0wzNGtxZlA0Q21oTHlr?=
 =?utf-8?B?dUpwUlBad2VCaytZZmZiM2lxaGJ5UHQzZkdTTzl0RFFIRUY0MFYrS1Y2SjRx?=
 =?utf-8?B?bVNBcGFBdWdsRldqdUo0a2VPMjNSVjlWWTZDOGdEYUFsa0Q5MEk5MEtsc2Ur?=
 =?utf-8?B?UTlRaWVPdTRXVkpGWE1PcWdWR0lKaEsrTWlCZzMxTkxpTGQyeS9POTV1MkQx?=
 =?utf-8?B?eC8zQUZSVFVWNE5PQ2FBejJwYjNFQjdrRkd6TDlDRE8vWTg4QlpBdTF5Z1hH?=
 =?utf-8?B?S2xMbkI1Y1g2cjUzUkY4eExpM2hsc0lHUEt2eXpETzl4dVg4RjdVVEZJeDRR?=
 =?utf-8?B?dEtoeGZjUFNvcmIzZ29jdnNha1dRSVB0b1NOVXNCcjh5TGRodnArTEc3Z1dG?=
 =?utf-8?B?OG1qWGg5Q3NuMFErTk5ISStQck5RUFVXdk45WWpPZVVOd0hpY2V1ajQzNGI4?=
 =?utf-8?B?Rk1Wek9qZmlWaVR5Nm5hUXZ5L3JMcHFENUI5bzk0Qlh3cHhyWEdoRmlrUTFG?=
 =?utf-8?B?OHNCNmd6MGxTSGRmQlI0dSt1UFhFOHpKRTBtQ0hHV2dqUGp3aFV1WktKNFQz?=
 =?utf-8?B?ZUViQ1pjU2RHL0VQbGw5T2dLb1VvNXdnVDQ1Q3Q3MEhPQkY4bnJNWTZFckV3?=
 =?utf-8?B?NmUzcjhXOVlJV0ZPTVYrdlRYekhLbHF4UUx3cWF6L2RhRFFIaWJlSHJRcVp4?=
 =?utf-8?B?MFllcTZWa3JjZFRmbytQcWhxakoweWVabWxWUlJYbWhpMU92NGh0bjY5VVE2?=
 =?utf-8?B?bTBCQlNNRDV4V285T0NEQ0ZKN1MrT3g4aEEvMDJtbmdVVnNWaG03cCs2c0pV?=
 =?utf-8?B?dUJRR2trM2xNZkh0SUZuekR6Q25NK1dkVnJkdHFMK1JjNml4YVorSXp1MkRi?=
 =?utf-8?B?MEVKTng0dVN0SjFqSHR6Ymd6a0cvd1p3eFBkQUY5UEhjTVJNSW1DbStiM0Z3?=
 =?utf-8?B?TUdPYThpRTNCWG1QZmR5VWFML2tiQVdzaVBwVTVVeEx3WHUwbUkxd2tWSi9I?=
 =?utf-8?B?UmxnTFZPbXRUWHBBckhYSE53YnBlTnFXUG84eTdmRE1nQk9uLzFRdysrcnZH?=
 =?utf-8?B?UFdqRXRhK0hRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T3JyVjl1cjZ6N3Jsd25hMkNwTlJxMUI4dCtGRFpGMnJ4ODdOcEhianNwN0VX?=
 =?utf-8?B?b0tBbWRKY0padElZQ2N1VGJUbzdOcG9UWXFtSWhCN3pEMnlRR3Q5Z3ZGcHFv?=
 =?utf-8?B?cG93OUxuM0FaTWc3RHlVZTg2NlhJazNLYWNPWFlZRERya2hWL0l4cS9JY3dG?=
 =?utf-8?B?QXVHNU0xZVlTb0FqOS8zMGhwYzd4VEZLRy8xZ2xyREJEbGQ0TGJlUEdJWW9y?=
 =?utf-8?B?NEw0Q0toRVJJS0dGMC9LNzZBZWtWRTV5MTVUMlpNRDNYTVYxSk1TVk1GcTVa?=
 =?utf-8?B?VGZWZHFHS0FpL3h5MWp0VkxZQXhFQ29DLzJZZVVHN2YyRlNwN1AvRlYvRVgx?=
 =?utf-8?B?OWZ6SjZ1WFUwc2pEUTJwc3Ava21naFloRm4xSi9Id1JSck1HZThMZ1dMdnN6?=
 =?utf-8?B?cEhWS0Fzd1ppQ29iQjQ2Mm8rS2tTMjJlbVJveVlBby9idDd0TlZjZkNoK21k?=
 =?utf-8?B?QklKV1VPaTBSY0RkeWw4YmRlelFGUmFHWlU4eUtPdGxTOG1FQlk0V1FTRDJp?=
 =?utf-8?B?V2czNFUycyt5OUZWNFFCM0JEK2V5enB2MWZlOHVKODhvc1lqS3RsSHBEMWZr?=
 =?utf-8?B?WFowbFR3Ny9UQlI3aFRhd2dGOHpIYlhOa3Z1TXUvbTdhNGZnKzdNeEhNWW5V?=
 =?utf-8?B?ZEhHSzZBVkdvNHBLYkpSQmlKZGxUMTdaaFo5ZE1kMmsyMDczeHA2Z2grVXhn?=
 =?utf-8?B?cktnV2Q3Z2RCRlRmRVBFbDZwZFZ1VXpxNHZMYnB0TEFRTkVSK3Rza01kdEJK?=
 =?utf-8?B?Smx5eWQzU2lFVnRhSnY2Tlk4eXplb2FuZ2ZLaU0zVGk0V2gxZTBld1pnMStJ?=
 =?utf-8?B?NUdrcmNtS1hBeHJaVWVsaGNaQ01qQjVUWVZQK1g4NVNqSERZMFBSZGFqb3Rw?=
 =?utf-8?B?UXpnbEpGZjlqR2hSOGJIa3pyb0pkOEt4ck5wRUtTR1hyOTAzT3hTRmpybVJl?=
 =?utf-8?B?RHE3RDUvZHFvUjZQOWYzdGxGd2hYc0xzeWYyYjRCTVlxaFVxTXNKV0xYMExF?=
 =?utf-8?B?di9nNGV5OWZiVGlnUmVYeVRxbFRhZm5OY1Fsb1B3cUt4cDFXNFJCNTRCeDNq?=
 =?utf-8?B?VVdmTHRXSjBNdU13SFBRK3VlNVEwT2I2bjFGd05MVVJBak1xclhUTTloOXll?=
 =?utf-8?B?cXNjR1lHSnhQTzY3dVBCelJPbUZaNVFqS1p4SUZhT2RKMytmS2p3TXNkUVJF?=
 =?utf-8?B?aTYzYlFZSDNGejVrK1N4cmkrbVVncUdQWFl1cS8wOFVJYUN0d0prUnVOK3lJ?=
 =?utf-8?B?VW5FRUs3blVjbG5TcldmUjZ1eFVuQVRjVDZ0OFlBeGFlNmdMYVNMT2ZyT09m?=
 =?utf-8?B?dHVDek9IbUZxdnNobmVQRDVhRndoeVBnb3dqYnFDbW1ML3pXNDhDZFd0ZUQ4?=
 =?utf-8?B?amU5N1FYNGM2VWRaanEvbWNHaEFDdFoydkRIZFF5UFFSK3kwZm0rSzBVSXNN?=
 =?utf-8?B?eWhGdjVLc2dVVDlRWXF2TGNmdFJCUDQ5UGUrODcvRm1HUFRYa2Zndmx6R0NP?=
 =?utf-8?B?WEs1eVl1anI0YzdoRDJ0UzhBZkdsNVJMUHJjaWdSZGpnRW04M1E1Z085VEpE?=
 =?utf-8?B?bzEwMC95L2NUdWZTbWYwZ09CS09QMFk1NHdsSy83RVB0U043eEh0N0RwcGhD?=
 =?utf-8?B?Qkp4Wk5vSllvQkRZZFpzUzA0S0dkazFCZjg5MmVVYWVCbXZnYzhkelcvazRM?=
 =?utf-8?B?SFdmRUppbmk5QXZac0JkQk1hOVh5NEFzNE9pZHlqSFRvZ3RqKzZTbG43L0da?=
 =?utf-8?B?cm5KbTRrSnVMNGFtWjU5TUdzeDZrdHlmOHFzaUVPVThoQW1kcnVoNktSS2Nk?=
 =?utf-8?B?RE1wckYwaS9vRlFUajJOeHNzb2RHZWU2TGMwTmJ6SExMaG5KbU43N0duMm5J?=
 =?utf-8?B?ZUUrcWo2WjdwN1Nqbzdma01UMG5VL0NWSkJsZ2R1UDhNdGt1R05WRVpDSVE5?=
 =?utf-8?B?YkFMNXRSR3NSUjF2MmYvL3pJZ2pzNkY5ZU9JWWx6d0cySHFaZlhHUmZtcW1S?=
 =?utf-8?B?WnoxaXJyYktwQk5oWGpuSTNGd3oyenlQZUsydWdZQWNVVDhqaHVOTXMwTzBP?=
 =?utf-8?B?UFMyMkp6NnhXMVlaNVY4WWxYOFNvUUJjcTBqMEdJV2tVdyt0cVNRZlMvaWYx?=
 =?utf-8?B?a0M0L0pNUnN6R0VhTzJ1KzlmdmxhcitwbExEREttZVhEU0l0Y3BaTHdBK2w0?=
 =?utf-8?B?NnBjaU5pdG1uSTJFNmhCZ1lvQThHOTRHb2FNTHhOSlFHOUpHK1N1M0tZVm5N?=
 =?utf-8?Q?azR1ydXJwj6zJ227ZKP6b0xUaSyHcN583ucFpOlZlA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe4064-aaa4-4f18-f36e-08ddc38ddad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 10:53:38.5095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aav+As6onPoDpemDcXGJU1zC5+VgvJvba230201EOVfLupLZabbXd66oC8FEWic4rD5lC9JfOUNXMlfm/+XZn5EIn2tvi34XEL1MQDZqOMdHN3QP4QdlIiU5uoEuFpRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 10:53:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19537

SGkgSmFuLCANCg0KVGhhbmtzIGZvciB0aGUgcmVwbHkuDQoNCj4gSG93IGRvIHlvdSBhY2NvdW50
IGZvciB0aGUgZG0tdmVyaXR5IGNvbnRhaW5lciBoZXJlPyBXaGF0IHlvdSBnZXQgaXQganVzdCB0
aGUgZG0tdmVyaXR5IGNvbnRhaW5lciBzdGFydCwgbm8/DQoNClllcywgZnJvbSB0aGUgZmRpc2sg
dG9vbCwgSSdtIGZpbmRpbmcgd2hhdCBpcyB0aGUgc3RhcnQgYWRkcmVzcyBvZiBST09URlMgKHN5
c3RlbWEpLiANCg0KVGhlIHJlLWNyZWF0ZWQgc3F1YXNoZnMgaW1hZ2UgaXMgd3JpdHRlbiBiYWNr
IHRvIGEgb2Zmc2V0IChzdGFydCBhZGRyZXNzIG9mIFJPT1RGUykgdXNpbmcgZGQgY29tbWFuZC4N
CkluIHRoaXMgY2FzZSwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBST09URlMgaXMgbm90
IGNvcnJ1cHRlZCBoZXJlIGJ1dCBvbmx5IGl0IGRvbid0IGhhdmUgdGhlIHJlcXVpcmVkIHZlcml0
eSBoYXNoIGRldGFpbHMgYXBwZW5kZWQgdG8gaXRzIHRhaWwuDQoNCiQgZGQgaWY9L2Rldi96ZXJv
ICBvZj1jaXAtY29yZS1pbWFnZS1zZWN1cml0eS1jaXAtY29yZS1ib29rd29ybS1xZW11LWFtZDY0
LndpYyBicz0xIHNlZWs9MTU3Mjg2NDAwIGNvdW50PTI1NiAgICgxNTcyODY0MDAgLSBzdGFydCBh
ZGRyZXNzIG9mIFJPT1RGUykuDQoNCkluIGNhc2Ugb2YgYWJvdmUgbWV0aG9kLCBJdCB3aWxsIGNv
cnJ1cHQgdGhlIFJPT1RGUyBjb250ZW50cywgdGhlcmUgYnkgbm90IGlkZW50aWZ5aW5nICAvZGV2
L2Rpc2svYnktcGFydGxhYmVsL2hvbWUgZmlsZSBhbmQgZW5kaW5nIHVwIHdpdGggcGFuaWMgZXJy
b3IuIA0KcGFuaWMgIkNvdWxkIG5vdCBmaW5kIGRldmljZSAgbWFwcGVkIHRvICdob21lJyBjYW5u
b3QgYmUgZW5jcnlwdGVkISINCg0KQWx0aG91Z2ggYm90aCBtZXRob2RzIHVzZSB0aGUgc2FtZSBv
ZmZzZXQsIHRoZSBib290IHdpbGwgZmFpbCBpbiBkaWZmZXJlbnQgdmVyaWZpY2F0aW9uIHN0ZXBz
Lg0KSWYgeW91IGZlZWwgdGhlIHNxdWFzaGZzIG1ldGhvZCBpcyBjb21wbGV4IHRoZW4gd2UgbWln
aHQgbmVlZCB0byBpbnZlc3RpZ2F0ZSBmdXJ0aGVyIHRvIGZpbmQgYSBzaW1wbGUgc3RlcCB0byB2
ZXJpZnkgZG0tdmVyaXR5IGNvcnJ1cHQgaXNzdWUuIElmIHdlIGRvbid0IGZpbmQgYW55IGFsdGVy
bmF0ZSBzb2x1dGlvbiB0aGVuIHdlIG1heSBuZWVkIHRvIGZpbmFsaXplIGFueSBvbmUgb2YgdGhl
c2UgdHdvLiAgDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNoaXZhbmFuZCBLICAgICANCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+IA0KU2VudDogMTUgSnVseSAyMDI1IDE1OjI1DQpUbzoga3VuaWphZGFyIHNoaXZhbmFu
ZCjvvLTvvLPvvKnvvLAgRElUQ19ESVQtT1NUKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJh
LXRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBkaW5lc2gga3Vt
YXIo77y077yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAu
Y29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8
sO+8tCkgPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQpTdWJqZWN0OiBSZTogW2Np
cC1kZXZdIExBVkE6IFN1cHBvcnQgUk9PVEZTIGRtLXZlcml0eSBjb3JydXB0aW9uIGRldGVjdGlv
biBjYXNlLg0KDQpPbiAxNS4wNy4yNSAwODoyMSwgU2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJh
LXRzaXAuY29tIHdyb3RlOg0KPiBIaSBKYW4gJiBDSVAgbWVtYmVycywNCj4gDQo+IEkgaGF2ZSBp
bnZlc3RpZ2F0ZWQgZnVydGhlciBhbmQgZm91bmQgYW4gYWx0ZXJuYXRlIHdheSB0byBzaW11bGF0
ZSB0aGUgZG0tdmVyaXR5IGNvcnJ1cHQgaXNzdWUgaW4gTEFWQS4gDQo+IA0KPiBTdGVwIDE6IEV4
dHJhY3QgdGhlIC53aWMgcGFydGl0aW9ucy4gDQo+ICANCj4gVGhlcmUgaXMgdG9vbCB3aGljaCBo
ZWxwcyB0byBleHRyYWN0IHRoZSBwYXJ0aXRpb24gY29udGVudHMgZnJvbSAud2ljIA0KPiBmaWxl
IGkuZSA3eg0KPiANCj4gJCA3eiBlIGNpcC1jb3JlLWltYWdlLXNlY3VyaXR5LWNpcC1jb3JlLWJv
b2t3b3JtLXFlbXUtYW1kNjQud2ljIA0KPiAtb2ltYWdlMSAkIGxzIGltYWdlMS8NCj4gQk9PVDAu
aW1nICBCT09UMS5pbWcgIGVmaS5pbWcgIGhvbWUuaW1nICBzeXN0ZW1hLmltZyAgc3lzdGVtYi5p
bWcgICB2YXIuaW1nDQo+IA0KPiBTdGVwIDI6IHVuc3F1YXNoZnMgc3lzdGVtYS5pbWcgKFJPT1RG
UykgdG8gZXh0cmFjdCB0aGUgYWN0dWFsIHJvb3RmcyBjb250ZW50cy4NCj4gDQo+ICQgbWtkaXIg
dGVtcF9kaXINCj4gJCB1bnNxdWFzaGZzIC1kIHRlbXBfZGlyLyBpbWFnZTEvc3lzdGVtYS5pbWcg
JCBscyB0ZW1wX2Rpci8gYmluICBib290ICANCj4gZGV2ICBldGMgIGhvbWUgIGluaXRyZC5pbWcg
IGluaXRyZC5pbWcub2xkICBsaWIgIGxpYjY0ICBtZWRpYSAgbW50ICANCj4gb3B0ICBwcm9jICBy
b290ICBydW4gIHNiaW4gIHNydiAgc3lzICB0bXAgIHVzciAgdmFyICB2bWxpbnV6ICANCj4gdm1s
aW51ei5vbGQNCj4gDQo+IFN0ZXAgMzogQ3JlYXRlIHNxdWFzaGZzIGltYWdlIGFnYWluIGFuZCB3
cml0ZSBiYWNrIHRvIC53aWMgZmlsZS4NCj4gDQo+ICQgcm9vdGZzX3N0YXJ0X3NlY3Rvcj0kKGZk
aXNrIC1sIC1vIE5hbWUsU3RhcnQgDQo+IGNpcC1jb3JlLWltYWdlLXNlY3VyaXR5LWNpcC1jb3Jl
LWJvb2t3b3JtLXFlbXUtYW1kNjQud2ljIHwgYXdrIC12IA0KPiBuYW1lPXN5c3RlbWEgJyQwIH4g
bmFtZSB7cHJpbnQgJDJ9JykgJCANCj4gb2Zmc2V0PSQoKCR7cm9vdGZzX3N0YXJ0X3NlY3Rvcn0g
KiA1MTIpKQ0KDQpIb3cgZG8geW91IGFjY291bnQgZm9yIHRoZSBkbS12ZXJpdHkgY29udGFpbmVy
IGhlcmU/IFdoYXQgeW91IGdldCBpdCBqdXN0IHRoZSBkbS12ZXJpdHkgY29udGFpbmVyIHN0YXJ0
LCBubz8NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVz
DQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=


