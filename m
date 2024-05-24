Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BCC25B75
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 00:31:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.5470.1716510649877397861
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 17:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=k1tLILTv;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1716510647;x=1717720247;bh=6r3Mpxv1Am+2Ky79+mFdrzXJqTZSwdZU1hRiX85
	NoDg=;b=k1tLILTvZ/TbH/GVsiG8Ltf0I84KG/NfI+3rjgrGg2fi+YQnmPYhEg7eflUkyFDnA3b3b
	FEByEEIFGv+NKDFt17QP5x2KA0CJq0qVQDEj3kQsxduSKY1P6SfHSWwxTHtmXzKy3dV72oA/UzB/7
	hZIKktqnmjuOGETa3EwZk9Sqx6y6mPDQ65HHOXPirNbSFbRKuxt2lRdGnun9SkVYBqhUa4SP+HUA6
	odO/PQ9+IPQu0GwAYtzzHUoHMPTFMJJKE2r2ROMr1SOpMmF1ronRBF29wZy1Ma3q9ZxKRiv61LTU4
	ChVCDuESkXpI9NF/My1zF9JNad6GvCsFRpy5/NBzfA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 44O0UkB01641720; Fri, 24 May 2024 09:30:46 +0900
X-Iguazu-Qid: 2rWhyQ028CCXDmjVsu
X-Iguazu-QSIG: v=2; s=0; t=1716510646; q=2rWhyQ028CCXDmjVsu; m=JqVVrgOJe8K/MitXIPnm1Q8Tvm/lsGnLqfWQgKMfcxc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 44O0Ujh7031470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 May 2024 09:30:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmqEBaaJl8s1UoxLPEXwMEpi1fVAMv7ZKe/FzAIASItWIVMWAwi9vre21uu9M+kUh09gJgVSeWxnQHP2/3TzgW50RBCP9/1Ali6nj18KZZTA6XAg158E4MmoAiLWG+/oSVAGCTv0VqpFttOqFfOxT2xr733Yrn2WVKusgtzHEXALtZZc1RGUf3SQKXF2xCr4ras9JAdzGCRFGcmpzdhg53YSIMy/eKm6R/HDkubTnB/TuOWHOmsIZWLLwefgVelhRReT5KE+TziqHm4xS2JgdsBNFOyKhK5u0Ch5h9/21rM9FhbE5thkoNdnT3PmmrLMeHNRuEiefbrkMnwnDjVDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hg/QPZgk8qLz3dG0DfkyJ7mrTzeIgHwMLag9XrhivE=;
 b=UTsrq1b/F3nbEC0aygysGw2QPfP0kr/2EKvjIouI9FrS1qo4bc5UlaLICP8duMvGcgDPftHsWYrWgs2brbotnCrxkCzQtrbaurPp7EzhixqJM+nRb12ix1LhtyF5J7K3zVG76qmzzZEXSpyxsPMrY+0C2641QiIvxZUIm2gECaWtakxASzK8skTk9yPxbXCUi3mO5MKyi+dxpH37vdQNEH+bnn9K9iPeHAyPAjlMZcyKvyqHZE5bjrVZ4NBA1c5Cfn+pScx3UJ+8t1CvdmH7/55klQS28VvfZT0JrDgX/eHMzXO8lw8uIllgH27ZhJQ3k2Bck013BbbiKmuqQiwuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH for linux-6.1.y-cip] usb: xhci-plat: Don't include xhci.h
Thread-Topic: [PATCH for linux-6.1.y-cip] usb: xhci-plat: Don't include xhci.h
Thread-Index: AQHarXDKBCBgvu7ilESAZwq5uDDFtbGlh3Uw
Date: Fri, 24 May 2024 00:30:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388ADF03B05B7E40421F1A492F52@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <1716510288-3420-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: 
 <1716510288-3420-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB7387:EE_
x-ms-office365-filtering-correlation-id: 87b99ba7-6586-4d14-33d3-08dc7b88bf4a
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cUYvQUxRYndtc2h1U29PL1RqbzdBUGJmaEIrdW1VcjBJL3FjejhXdzNn?=
 =?iso-2022-jp?B?bVprVUQwbmtIQ0RyNm83ZFArdy9tUm1XYUNUaUJmTDVscDRYRGVIZUZF?=
 =?iso-2022-jp?B?cE5uZ0VVMUFQQTJFMk5QUDFzMmw2bi8zcFJxbk9Tb29Jek9kMGFQT3gr?=
 =?iso-2022-jp?B?eVdvTThNWG9NWEN5QTJoN1hpcXFoQkZvQ2tBVWFYQzBQblpQemRING1h?=
 =?iso-2022-jp?B?cXNETEl4QVgweFhXT2FINUd5VlFXZkdJKzFuek9MeEc3eW1YNjVKaytp?=
 =?iso-2022-jp?B?SzlVMDFvTEJYNTNVeXdMQ0doUmZ2SCtiNE5idDVPOTRnQnNyMncrN3JV?=
 =?iso-2022-jp?B?Z21XalFzZHBqYkZBVk9scGV5Q2ovT0dtZTEyM1I1VldSd0FaNlhJUldY?=
 =?iso-2022-jp?B?UzN4d3UwVS9PSStyajZYTDZ6dkxKTmxUdzNrbTB1Vmw4Y1E0NkZaTEFo?=
 =?iso-2022-jp?B?RUZ4TStzNW1OTHlvV3V4UWN5bXlvdVVaWmpKQnBDMFI1MTdtcGxuTHlH?=
 =?iso-2022-jp?B?RzRXK2UxNCtNSVVtT1VoMWxmTS83TmMwMmpTMjdpakt0L1hYcGdqWmxs?=
 =?iso-2022-jp?B?akM2REI0VXQwczFYVE9hUW1ZRmV6Z1lpWkJIakpQZnQ3azhDNjV4c2hi?=
 =?iso-2022-jp?B?QXhYbURpTWdsWEltQ1VJZVJVVUdVR1hpUlV6VVFRMDU1aUV3VkNjQVVO?=
 =?iso-2022-jp?B?ekszZnN5NkYxNDE4cU9XZ1grZ05hSFZiTjFsWFJrOUhMNmdYSnFWSjd2?=
 =?iso-2022-jp?B?c2dQa2hFemxvcnNHNURUQ3VwdkZGY2tjUjdDZkJwektiOEFvR2l4K1Yr?=
 =?iso-2022-jp?B?cWVmZm95c0dlMlBzeUduaTB0K3pFY1ZRVkxHVDIwVWs2UUl2RmpYVGhH?=
 =?iso-2022-jp?B?ai9QcTZWTlFrb2tTaDl4N2JRUVM4K2lNMndta1RaNm1sTzh6Y1YydUg0?=
 =?iso-2022-jp?B?TXhRa1hXSDl6ZmVESmtmRUx2eWQrcjFRVFZlU0I3eS9uMzVQQlpmeE9Z?=
 =?iso-2022-jp?B?OTNzc3I1VWREL0VoNmhJMWROUjNhKzBSb2RqYUJpaUVJdUpjZTlZeGlC?=
 =?iso-2022-jp?B?L1NwWEZaTmdPbnI2YmR2alBDelNVcm9UNWIzWjVkNzA2b3FLOTNRYnVV?=
 =?iso-2022-jp?B?dTNwZ1lUOThNNENRUW1uRGJtVkhFRlBJejNSOCtSLzZ5OEpHSEo2bFZM?=
 =?iso-2022-jp?B?bGU0Vk1xTGRZbGVHTVFCZW5Gc3JraFQxdHNqSUFvbkpveGNoc0ZTalQv?=
 =?iso-2022-jp?B?ZFVNREpzNEdGUmd5blhCV1dJMUxHWDA4cERHc2dXcERXV3hsYk9zcjlK?=
 =?iso-2022-jp?B?ZWQ3bDErNTNaMmo0RmtnTXkzQkNpRCtuVnVVTWUvOUFuQklFNjJNUUl5?=
 =?iso-2022-jp?B?RFNhdGgweTBWNHVkakVIWmhYdEhVekxFTzRrZjNPUzltbVZKSG8wVUt5?=
 =?iso-2022-jp?B?c2EzeU5PR3liOGhtdmwzOWN6YVhuVnJJUytISnZSSyttZWp3aUIvc3l4?=
 =?iso-2022-jp?B?K1doemVTbkNRVzdLd2dwOHZoTG40UHhadGRpTWhDKzg2b1pMZWpQMHc1?=
 =?iso-2022-jp?B?MjQ1QlJzVzlTaXhhRUJjSGd3b2JiS2tPTHoxSWFkM3JqY25YVXhuV1lS?=
 =?iso-2022-jp?B?dUV1cWtnTUZqZDE1U2NIN3ZwSGplM0hncnFRbENUZnhCak5kbXprNk9m?=
 =?iso-2022-jp?B?QlVVdkNCL1BGYlI4RVBrcWpGc1FxQUliRnZwMUhxcnRMbkViN291dU9L?=
 =?iso-2022-jp?B?QU1NWXFzSTBndVBpaU8zZm5LUWZhQVVsb1U0QWVxbG90TG9tVzc2ZzY4?=
 =?iso-2022-jp?B?YU1qbzRIZ1VrNXZob3ZSMGhoUTN3b05XK1dVTm9aMEpPNFpUOC9sOTRZ?=
 =?iso-2022-jp?B?eW42SXpycFp6THFWcENjNnVJNWdyLzlTUzVGTEhlb3ZiYkdyeWk0bmRV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cGU4ekR4OTQvQ2d3cWY3VXROTmIwblBWQmVwSUd0ZHdJMUJka3hvVStj?=
 =?iso-2022-jp?B?em5EM0JkTFlHc1FOUU15djhNS3cxZ0NOeUhtNXMrZW5zQ1ZUM2hMVld1?=
 =?iso-2022-jp?B?Q1hZMC85VXB3SldwUmNla2FvUE1tcXgzUGw2OEdpaDhJblowNmJkdGV4?=
 =?iso-2022-jp?B?SWxtNWd6TEVyNHRSUVd6ZzZqdDdoWXprZDl4UkovVXJPUHdiODZsV0wv?=
 =?iso-2022-jp?B?VFA5ZHFqTzRXR3NRaVNBZTYvWEJ0d0x0UVVMc0xVUE9tSXdtczBsb2o5?=
 =?iso-2022-jp?B?MnArWlY5SERzZFFRT3BrYlFTZFViYjFLSHhhUzNyMTJINjdIY2hjMC9s?=
 =?iso-2022-jp?B?TUkySXNweGZiS1RRZ2dST2tVRkNwVXNhRUlQMzRDRHJzUldLUTFOV0V3?=
 =?iso-2022-jp?B?U1V4dzlhaGE5RlRHaklpV0Y4QlJjSjRNSHYyUTBDbDNYbExybEcvQkxZ?=
 =?iso-2022-jp?B?TCtUa0UycGJaTElpWWhLT0FwSS9BUGZZTklKREdrZFpPQUNrdm45NEFr?=
 =?iso-2022-jp?B?a21STm5qY202ZExmYUczYkRxRWgxK2wwQ3ZTL2gwTUxERnFQN3lvRFBi?=
 =?iso-2022-jp?B?Q3V3elJTQXlMRjZMUk1WZURPbXRtUklWZ1Yzd3c1V001ZVZHbDZFbjh0?=
 =?iso-2022-jp?B?NGNiWTdQQ3VqdEhud2p6dG0zNTBDa1ZBWG5acFp3Tmo0enVEUmdEUUxI?=
 =?iso-2022-jp?B?bHFGd3dTT3gyeGQ2Ni9zQnZJT293c1J3V2pUdmEvOWRVbWZXSzMrc2tX?=
 =?iso-2022-jp?B?eVROTXdVakx1cnc4ZzZBVlZRejhmRzFQOGpKN0JkMkFyQ1R4aUNldElP?=
 =?iso-2022-jp?B?RzRiQStPZzFMWVZUVWJLY09TdWhRMDY1eHRENXVoNzR2OUR1QjJ3TFdZ?=
 =?iso-2022-jp?B?RHB5TFM5QjdRU0p1T21uOXdDOWQwcEg0SEsvOVozNmtOV2JCNmNmVFp4?=
 =?iso-2022-jp?B?dWh2cXl0VUJINjRvZWFrdndiVzR6SW5hbGFmZWduOXNOdUxrNTJ1eHA1?=
 =?iso-2022-jp?B?TGdKaDJVdUZXdmpEYjU1Z0FYMFRvRHlrQ1JNbFpBbEkwTkJyK1lIVWJ0?=
 =?iso-2022-jp?B?WWJKOU0zcFZRSHc5OWRZMjZJZkVUdWZIK01ZV3c0dmZaa0hpUWdiNGtt?=
 =?iso-2022-jp?B?NTN2L3ZtaVJyblNvRGdvcW1XNUppL0x3LzhKZ2pqY1JkRkxCcmsxVmlC?=
 =?iso-2022-jp?B?Rys2Ykt6ekRTQitvZ3cycnl5UlNrajVjMklsVHdTZ2YzbHFtaktUd1Q2?=
 =?iso-2022-jp?B?WTYvN1ZnOWpJZnlyNFQwOWdSSjZUdXNkM0Y0eW43b3E4WmlBSUdEeVZz?=
 =?iso-2022-jp?B?TFFNNHdkZFBpZHkzSzBCdjF2WG0wMnVJLzV4WlNqS2xINCtuQ2x1S2Rw?=
 =?iso-2022-jp?B?dUxJb01SaFc4UjREcXBnL2lFeGwxWnBoakk5NThvZ1FMcmIwRlhkUzMy?=
 =?iso-2022-jp?B?YisxUzRTNlArYmRiMWEzcGVQQndGQ2NJc3VXRFdhN0xnaHpvN0UzdkV1?=
 =?iso-2022-jp?B?Z1FjTjBMQ1VZOHNRVWFFRU45V1dRRWd4eEQvMjV6SGRQM3dkY0tpeklJ?=
 =?iso-2022-jp?B?M253ejFXdWYyYU44VVFCS0V6a1E0aDJETWpkVWN3aGtsZDVOd3crSEJ6?=
 =?iso-2022-jp?B?aEc2aFZRb1pKUms2MkUvMkJKQStvR1hGN1pJVjVKTS9wNU1QVTRSZXdm?=
 =?iso-2022-jp?B?NlhJYnd3T1pRTHo2Uy9VS3poZEVDL3BtR3VxMjByQzlqaUo5aS9iVnpt?=
 =?iso-2022-jp?B?eC8zQWZEZ3p1YXVqdzNidE8rZ1FNK3JYTVZHR2VTbktrUjNZUWhZak8z?=
 =?iso-2022-jp?B?Q1NFTjJEQStPbTBaUzErR2FtSXpWZXNmYnVMZkg4ODBzaU5lSXh5K2Nu?=
 =?iso-2022-jp?B?N1FSb01pZ1NkYjlrVERpdWgzcmpXRC81U3BpV0pWbmY1RlJyRWxJSTdn?=
 =?iso-2022-jp?B?R2szWDZVSk45OThNM1NaZzIyR3pKVXRSRVpoSWI0dS9pMHp1UU15WE1q?=
 =?iso-2022-jp?B?bi9oZ3g4bHVlQXBhZlk2RmRXcTFQM3Uwa1JWcTVJTmY0SnVROEswYnlO?=
 =?iso-2022-jp?B?V3VPcWdOZ2ZuQXoyT2lLbDdldEJVM0lWT3BKNlh6UW1GRU1NU2VuRjda?=
 =?iso-2022-jp?B?R0RxL3ROUG9zdmFySWxTa29jY3prYnpoSkZoSEI0YUwxL1V6c0NkV2x6?=
 =?iso-2022-jp?B?cDZjdUdMdHpTcGtPdVR6eG56SjFRMHV2aDQxbDdyZVpSVm9oQ0FySnRH?=
 =?iso-2022-jp?B?NDJJbi9MY210QndCSXVzTFRGNmNZMWZZTFFUbHJxdEVoc0RoOXkzenV0?=
 =?iso-2022-jp?B?WXpqbk5kREc4bmk2N0NyRFF2b3BHMnowUEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b99ba7-6586-4d14-33d3-08dc7b88bf4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 00:30:43.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LiVWxUz6n2BPqG3EcMH3alEcbW99uDP3G7L/yu+RmuGXKvw9xO2CRyBqaEkzfVxZIaME92rY0AQim1oSXCnAmxpT+VA7Nc3L6hu3PwIOXN5x5nCFgh4/zImY3mOkbWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 00:31:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15940

Hi,

> [iwamatsu: The original commnit of this has been applied to linux-6.1.y t=
ree as
>            bf3b0ab6fbae ("usb: xhci-plat: Don't include xhci.h") without
> 	   xhci-rzv2m.c. Therefore, this applied fixes for xhci-rzv2m.c only.]

Note: This fixes an issue when merging 6.1.91. There is no problem with v6.=
1.90-cip20.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Friday, May 24, 2024 9:25 AM
> To: cip-dev@lists.cip-project.org
> Cc: biju.das.jz@bp.renesas.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.M=
N=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: [PATCH for linux-6.1.y-cip] usb: xhci-plat: Don't include xhci.h
>=20
> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>=20
> commit 4a237d55446ff67655dc3eed2d4a41997536fc4c upstream.
>=20
> The xhci_plat.h should not need to include the entire xhci.h header.
> This can cause redefinition in dwc3 if it selectively includes some xHCI
> definitions. This is a prerequisite change for a fix to disable suspend d=
uring
> initialization for dwc3.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Link:
> https://lore.kernel.org/r/310acfa01c957a10d9feaca3f7206269866ba2eb.17133
> 94973.git.Thinh.Nguyen@synopsys.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [iwamatsu: The original commnit of this has been applied to linux-6.1.y t=
ree as
>            bf3b0ab6fbae ("usb: xhci-plat: Don't include xhci.h") without
> 	   xhci-rzv2m.c. Therefore, this applied fixes for xhci-rzv2m.c only.]
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/usb/host/xhci-rzv2m.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/host/xhci-rzv2m.c b/drivers/usb/host/xhci-rzv2m.=
c
> index ec65b24eafa8..4f59867d7117 100644
> --- a/drivers/usb/host/xhci-rzv2m.c
> +++ b/drivers/usb/host/xhci-rzv2m.c
> @@ -6,6 +6,7 @@
>   */
>=20
>  #include <linux/usb/rzv2m_usb3drd.h>
> +#include "xhci.h"
>  #include "xhci-plat.h"
>  #include "xhci-rzv2m.h"
>=20
> --
> 2.43.0



