Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98378C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 05:01:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.7831.1715662892665807508
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 May 2024 22:01:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 44E51U8q4083872; Tue, 14 May 2024 14:01:30 +0900
X-Iguazu-Qid: 2rWhYYPQEolUMpkvbj
X-Iguazu-QSIG: v=2; s=0; t=1715662890; q=2rWhYYPQEolUMpkvbj; m=XtHqaVM+IcNY08q4HmdLknkbbiUeBxTEkp0Gif6x9ws=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 44E51SMe3179947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 May 2024 14:01:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRklJsvQgpx4WLujEDLc9KpITCFQmcC7HYnVACyZf/HE85aGHNlRYLKoUfSZ9O2Vvo0C7XvlLkJ4dmPfoj6Btmn9BTSeb3YWHeHWOlR02F7p2ohzJV28qffsimV7TqG76tUfrm0zBj99YwxzjVUDtfsFkkPxuxPmn56Q1rOKK/yXVKwnB1v7wb/6opuIsoc9nLST24OLtDL+ZxeDRPXlTLIiB9GSo3mdGdVfRgU5EE+8hYN09ORyPVekNUSDKA1Yoyw1bGkLi/Q/os3FQzcma12o+3hlXPUHMlDNhKS1gElwo8chsAyBpeEie+rR6PP3EK8ptaqS73D5dsiRxY8slQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuc6R0rloYDSo8nVVTuOy/mW8wWor2w0c7NtucJ4fcU=;
 b=F3RNC5w5TLuOlyIrwzjSjyoUU4gi80GJFq7lzy52DKgWwlET0y3xZPquPTgWAFEQy7SqOPsbmzwNKqAzUviISelktsAFr5SZhiNEn3vJAH4RoTLai2WPCbpXIkP8hKxAA8H0orDMynoJhMjQ95UFycYqzc2jxpIiZqc5BDROuj85xVhK5KiLdFx4VCfVGuKA1SiciH8fqJhr4yQxnWvdYBwv2xaKKgX9dQUkZ0wlkqX+wo5DDV22i8qHXnMQkP5g1h9w+lHLtUN0zx804Eh2AWV6Jt4LI0MYc6cqk2QoH6DSblvEXXKqwTSvOWcWxTjFk3VfKH9+hKFaYi7oAiPe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [isar-cip-core] [PATCH] Add MCOM x86 target
Thread-Topic: [isar-cip-core] [PATCH] Add MCOM x86 target
Thread-Index: AdqckpcQz3qSMzH8TIiOyax9RYdnUAJKC78g
Date: Tue, 14 May 2024 05:01:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107541CD6CC53A98748546C4C7E32@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <GVXPR10MB58375213D66CD4C30A60188888182@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <GVXPR10MB58375213D66CD4C30A60188888182@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1d99b187-98d9-46d5-8325-af65e7891a27;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-05-02T13:09:35Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYWPR01MB9559:EE_
x-ms-office365-filtering-correlation-id: 317e93e9-08ec-43a1-c703-08dc73d2e888
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SHg3RUl2UzRScVBKVCttaHdLL3FQOURxOVU4djNVVm9EYVFkY3o3WXpr?=
 =?iso-2022-jp?B?ZXF0cmhMRWRlTVRtajRhQUNzcElUNjJWeCtaODJwZVFUZ3VjK0xwcTN6?=
 =?iso-2022-jp?B?QzFpbHY0amREK1Zta2ROQnRBNDZVeEMvVXRtaWR2UFdUL3VrU1pEQmp2?=
 =?iso-2022-jp?B?eFlqdm9oMVdBM2NleWZld1NtYjdSYUM3RkE4UDYzZGVxNEpLd1ZMcmdE?=
 =?iso-2022-jp?B?QVNDTkl3bVVZQVV5RElUYnpKVGo4bitFcmhVS1V1bEVzaXd4VmYwM0pj?=
 =?iso-2022-jp?B?R3hoSy9qNFZYTWttVlkzYis5RmVLWWVPb002a09NWEhZTHBWRmR3S2dM?=
 =?iso-2022-jp?B?ckZpVGY0ekI3TE5iZU1nYzhQWnlFSzlhUkR0dW1YVC9BaklVTGRGTW14?=
 =?iso-2022-jp?B?V0hSbDlERkV6ZjU0WWZ4K1RmZTc0NDh0MDZoNHhUOHFLVmNpYlpFVFRO?=
 =?iso-2022-jp?B?UnIxVmdGVzdLb1ViUmc1VWtlSG9WaVdjSTVQYy9uaGc2cUQvV2VEMlgv?=
 =?iso-2022-jp?B?TlFzakFGMHpVVkwyc0wzaFpCNWM0azBLcTNBVmorTTY0bGlXUitXZkcz?=
 =?iso-2022-jp?B?UXhzSEY2VG5QaGxaZXA2VjVENFdSNStTWGdFdmdtRlJGVHNodGVFc2Fk?=
 =?iso-2022-jp?B?SnVmTjd6N1FIdXYzTi84N04xSi9mQ3hVeXJIdWlrWnlKckJoUzZHVjlE?=
 =?iso-2022-jp?B?aFFkM1IxTit5ZHM1Y3hUSnVCQ2tjUVp2bHJsTFFJY2NGVUVLNTZXcWFZ?=
 =?iso-2022-jp?B?aHluMUJ2UDdYVk1IMzRpK2FxemRHYXgra0M1ZDhyTGFIYktHZlVLaDBK?=
 =?iso-2022-jp?B?OTV5RHppTERvR3F0NTZYWUlTSTdMeUhVK2JhSlowdXVxQnFCbFg0bEts?=
 =?iso-2022-jp?B?cjBTSVR6YWhvY0E4QWV1anNXVFoxSmdLM0NtRG8xTXhFczVKcGdLS2Jk?=
 =?iso-2022-jp?B?TDgxNm50THFVUk5IVmJoSHdKUFh2S1k5OHp6VGhrVFFET2plNkNPRVJO?=
 =?iso-2022-jp?B?QitMbnIvbjBGTlNGbEV3NS9NcktMc25WNTFpRXFodCs3eUk3S0g1S1Ix?=
 =?iso-2022-jp?B?V3FiK2NydnFJSDZDMk5zM3NSSTRVOE9TeEtLWXBWQWFrKzBUUEFCVnVX?=
 =?iso-2022-jp?B?V0F2TzRGb3RvSjEyK1NhTjVPd0thQXFuSFU1dFpwZHZObEtoZGVuQWJn?=
 =?iso-2022-jp?B?VGI3aTdIMzJJaVU3UVBDdzlvOUs0QVg4VTEyeG1nREZOSklpZUc5UTFl?=
 =?iso-2022-jp?B?S0ViQ2JiL1lFaDU5MTM2VVNhS0ZTNG82VW1FaVpDY3JBdGJIQXZFd2cv?=
 =?iso-2022-jp?B?eVBnUnNtVEFKZHoyRVhDWGs1WEFiMkMySUZzZm0wQ21iSCtaZHNZSVIw?=
 =?iso-2022-jp?B?cmIrTGk4ditXOEdGVTNRUk9keXM2TnZETTNxWXlNVTBEeDR3dVVlM2E4?=
 =?iso-2022-jp?B?VW5FdFVqUEw5bEJNU2liSFNtNEJjN1hWOFdwV084bWQ3bmlXb2VxOUNo?=
 =?iso-2022-jp?B?ZnJ4YjJEUUM0dG5mRndFSm1paUtIL2I2YmV4bnJjelkrWWx1QVYwSGhX?=
 =?iso-2022-jp?B?ejF2VW16dEcxbTMxbXBRZzdxYU5yRnUwOEZBMlU5K3VlbmU0bWx6dUow?=
 =?iso-2022-jp?B?cy96T3EwenRjVlJBOU0rOTJ4QUZYTFFMWlg0U0kwZHBIUVdiQWtYWWxh?=
 =?iso-2022-jp?B?STZ1aVJWaUZFV1lZOTNhenpyUEVwNHdXeUk1cXJLdklZWGZZZTEwL1h4?=
 =?iso-2022-jp?B?SUx0MmVDVXorcFVYWHV1SjNvRzV2R0Y2THZ5ZjNBdDVDQ1pVWWxCeWUy?=
 =?iso-2022-jp?B?OENQcjdselZ3ZGJWSk1RSUdyQ3N4U0xCc0RKZXlPREcvVGp6UGwvZkgr?=
 =?iso-2022-jp?B?Ri84NHFtNFZrOE1iVFJUUFJFZUtOenVESnN5bG5UY0pUVzRRdUJ1VUZv?=
 =?iso-2022-jp?B?N3NIYWt2MjFZbkZ3and4ZXZWZVBGdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y0t3ZldRMllYbWdvMWFja0FhcnRFRUZ2SW1QMTFxUE1lQ2tvclJGdVAx?=
 =?iso-2022-jp?B?QnkreFp6a1BIdEZoajFlN1dhWGFTZkJ3em5nQ0xpcnpONm5ER3R5NkNZ?=
 =?iso-2022-jp?B?a3RhNERCbENsRWlKQm5XU0FLRkMxN0QzazExSjlGQ3dtNE5iTUdTVVYw?=
 =?iso-2022-jp?B?VlZ2QkdmbUdQNktubVZORlJIc3JYSjFNTDlHUlNZTmNuWU1KTHNiaXRB?=
 =?iso-2022-jp?B?WWNHVXlVZ1Z4b1hWWWhvUTlDQ24xVVh5UlhtQmx4Y3FNSTd5NXlQZDQx?=
 =?iso-2022-jp?B?dk5zYXRCTWJWNUlkM0hvalRXd3pXd1pOdERjQU1FQVBSWEdROXhBM2xQ?=
 =?iso-2022-jp?B?UXJucjBLYWJWVitMVEd5OHNVbVZhMUxxSHQvYmljQm5PS2NJUllnYkJS?=
 =?iso-2022-jp?B?NzQxbTRMcG9CUUxUZmt0OXpOek5xWjlRSGFXWWZaMm1zZ1pRRDlLc2tm?=
 =?iso-2022-jp?B?MWZzUHRvbjZENDNDazFtM3hFcFFlcHMwYU9hVjNtSUlBTFFHSHlVNGpR?=
 =?iso-2022-jp?B?cTZ6aU9aQmgxRllwUDV3bVVZT0VLd3VsaERMVFEvSm8ra21GbUFvQThU?=
 =?iso-2022-jp?B?WlRqcXB2U1V0Vy85Z2cwMjVXNlBrTTRHblVMTUNiTDJ5L0RsaTBuVnpG?=
 =?iso-2022-jp?B?N1VZWjgrMEg2amVORW1za2dlWHBjZTdVNHM2b0xwcjN6Z2t4NGg3L3o0?=
 =?iso-2022-jp?B?KzlUUGd5UWZxamhoZEhOaDJaMm1xbWR2WlhiTTZpNS9MaWtEbVpTMjFU?=
 =?iso-2022-jp?B?N3Y1VjhMMHN1emJOV1RNb24xUSt0MzNLWlFsTWd2SVJqdnFCNy9JNHRT?=
 =?iso-2022-jp?B?UmtDWk5HbXAyLzRzOFhQa2VoNDNKNXA4K092d0Z6VzlxaWdxU0JmVlpL?=
 =?iso-2022-jp?B?WnpzY2toaHhOZ2ltZEViNUY3bXR2N0gwcG8vRDVwNjcvSTZSZ1FTcmk3?=
 =?iso-2022-jp?B?WlRMRTNTWEtGR0RlRlVtUnlNR0RYQWhnZTFrUVVrdWRwLzFLZnNOeWpH?=
 =?iso-2022-jp?B?MlNQeXEzSnVMVDZ3ZUdSbit6bTl5VGZIdDBaeUFzcGdKb21LYUw4REJa?=
 =?iso-2022-jp?B?RTFHMG5tbnU5Ullwd1B0Z3FqNzZIMU9xV0RucDdFYTlrSnh4TWdEWE9N?=
 =?iso-2022-jp?B?SkFNSU5zRHRVVFM1akdWMVhJcjRJK3JwRDVIRGZEQTRyVWpDc0xybUZX?=
 =?iso-2022-jp?B?RG54ZnhNOWt6Y1dLYitKUHpkY2RucW8wSkdwajdpWVRKN1VoYmJubFZQ?=
 =?iso-2022-jp?B?ek1lOFVQNDEvdjJFUm9EV09FMURoSEFFUStaS0lpTFhvWTlZYnBlMFdk?=
 =?iso-2022-jp?B?ald1NTNDaDg0Z2F5Sk9mSUtuTUJ5UW5JUm94SWRXd3hXZlhlMWIyMUc2?=
 =?iso-2022-jp?B?T2JxNk85cUwveFVkZnpGZ3JSU3JaaEE5WWpBOVZJZWRkZUg2UWRvR2Ry?=
 =?iso-2022-jp?B?bEd2ckZhaXZjbStNZG9hRG9aRDUvaVVZWG9mVzVzRC9TU1BLTTR4eHBS?=
 =?iso-2022-jp?B?VVM0aUlpYUVISTJMMUYwUkNmZTVBTnFBVkdyQlo1RHVwKzhOZ21CcTBJ?=
 =?iso-2022-jp?B?VXdmdWFtaWQ0bitqSzNtTUMwQTRPd2pGQ2ZPMktyUWJPbWNXNEs3Tkg0?=
 =?iso-2022-jp?B?dE1WUStJZ2JIbVNQTUtYaDc4MnltTW1uV3hDdG02bWFxa24velgrTnlp?=
 =?iso-2022-jp?B?d2xMMUFyRk1oN2lvd09kS29PenRIZytWV3BhdWs2ejAyTXBSU09vWC9D?=
 =?iso-2022-jp?B?ZWxENGRBSjBEVEgzbXR4cSs3S1g4Y2ptTTMzK1BYM1N6bithUDVtem95?=
 =?iso-2022-jp?B?OG1rRGd3enRvZWZkQTVIMjNYdnFxbnFvZVZqcEFENWdJa1l6RHFFaDgx?=
 =?iso-2022-jp?B?VnlGYUw3Wk1nbWFsLytvMjJTRW1PaGxoemZpMXZWUThWMVVVZXI3TXpE?=
 =?iso-2022-jp?B?b2ZFalhMby9MRkJLWm9DNkxTdEltc2RpbDZ5LzNxcG1zMGtYbnMwc3Jx?=
 =?iso-2022-jp?B?ZzNoMmVtd1MyWHRzRFk1RWJpcVUwOWN5TkxUQllvQnBtV3dGemZiNTAr?=
 =?iso-2022-jp?B?V0lWeVAra3oyenBaQkZCN0oxVC9OU2k3SGwvb1RYN1BxSkRpYnhVU2Y3?=
 =?iso-2022-jp?B?Y1ovd2hmRkNGWEY3UWJSbzlWUmxFUC9TdFdtYXVYZElYd0dBRU8vZW45?=
 =?iso-2022-jp?B?K3lGOXlPVlNKVWVKT1QvamFCZmlJdFJaS1RmR3dqVmpwL1NNdSt5Qm51?=
 =?iso-2022-jp?B?cHpzL29vdktCcTRJUXoyWHpldWxXUS8wTHVUcWJGMklhUFRXZEdUdGc2?=
 =?iso-2022-jp?B?RDdJbmJLejc5ZFdDdkVIbzZma0hOVkpYWW51cjZ2YTJSNFA0aHhMcDhZ?=
 =?iso-2022-jp?B?aFdOQW89?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB1107541CD6CC53A98748546C4C7E32TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317e93e9-08ec-43a1-c703-08dc73d2e888
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 05:01:26.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IkWT410F4qAmmh/VUCl3U7vlq9Uqk1DPf1JuX+brpr7yXMzvOVrSV4NZI0lsMpjipyHPl3bIN2a8h5WuRjy37XUJQdL69wQfQUIr/MsXxr+ZWYqR1eVwYP2Wt8xjV0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9559
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 05:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15887

--_000_TY3PR01MB1107541CD6CC53A98748546C4C7E32TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

The MCOM kernel configs for 5.10.y-cip/x86 are merged to cip-kernel-config =
master branch now.
Could you please send the revised patches for MCOM x86 target.

Probably, you may need to update =1B$B!H=1B(Brecipes-kernel/linux/cip-kerne=
l-config.inc=1B$B!I=1B(B file.

Thanks & Regards
Shivanand K
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Benjamin Schilling via lists.cip-project.org
Sent: Thursday, May 2, 2024 6:45 PM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core] [PATCH] Add MCOM x86 target

From edb4f62f1f11252bc82d34325130e072825d75ef Mon Sep 17 00:00:00 2001
From: Benjamin Schilling <schilling.benjamin@siemens.com<mailto:schilling.b=
enjamin@siemens.com>>
Date: Wed, 10 Apr 2024 17:21:11 +0200
Subject: [isar-cip-core] [PATCH] Add MCOM x86 target

This patch adds the MCOM x86 as another hardware target.

Signed-off-by: Benjamin Schilling <schilling.benjamin@siemens.com<mailto:sc=
hilling.benjamin@siemens.com>>
---
Kconfig                                    |  7 ++++++-
conf/machine/mcom-x86.conf                 | 15 +++++++++++++++
kas/board/mcom-x86.yml                     | 15 +++++++++++++++
recipes-kernel/linux/cip-kernel-config.inc |  4 ++--
wic/mcom-x86-efibootguard.wks.in           | 14 ++++++++++++++
5 files changed, 52 insertions(+), 3 deletions(-)
create mode 100644 conf/machine/mcom-x86.conf
create mode 100644 kas/board/mcom-x86.yml
create mode 100644 wic/mcom-x86-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 7c19640..89f7467 100644
--- a/Kconfig
+++ b/Kconfig
@@ -43,6 +43,10 @@ config TARGET_SIMATIC_IPC227E
               bool "Siemens SIMATIC IPC227E"
               select ARCH_AMD64

+config TARGET_MCOM_X86
+             bool "Siemens M-COM X86"
+             select ARCH_AMD64
+
config TARGET_QEMU_ARM64
               bool "QEMU ARM64 (aarch64)"
               select ARCH_ARM64
@@ -73,6 +77,7 @@ config KAS_INCLUDE_BOARD
               string
               default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
               default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IP=
C227E
+             default "kas/board/mcom-x86.yml" if TARGET_MCOM_X86
               default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
               default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
               default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
@@ -190,7 +195,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19

 config IMAGE_SWUPDATE
               bool "SWUpdate support for root partition"
-              depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TA=
RGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 &=
& KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
+             depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TAR=
GET_MCOM_X86 ||TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARG=
ET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M

 config IMAGE_SECURE_BOOT
               bool "Secure boot support"
diff --git a/conf/machine/mcom-x86.conf b/conf/machine/mcom-x86.conf
new file mode 100644
index 0000000..21bcd1e
--- /dev/null
+++ b/conf/machine/mcom-x86.conf
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens Mobility GmbH, 2024
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH =3D "amd64"
+
+IMAGE_FSTYPES ?=3D "wic"
+WKS_FILE ?=3D "x86_64-generic.wks"
+IMAGER_INSTALL:wic +=3D "${GRUB_BOOTLOADER_INSTALL}"
+USE_CIP_KERNEL_CONFIG =3D "1"
+KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/si=
emens_mcom_x86_defconfig"
diff --git a/kas/board/mcom-x86.yml b/kas/board/mcom-x86.yml
new file mode 100644
index 0000000..28c4674
--- /dev/null
+++ b/kas/board/mcom-x86.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens Mobility GmbH, 2024
+#
+# Authors:
+#  Benjamin Schilling <schilling.benjamin@siemens.com<mailto:schilling.ben=
jamin@siemens.com>>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: mcom-x86
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/li=
nux/cip-kernel-config.inc
index 40c378b..7acdc0d 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -10,8 +10,8 @@
#

 SRC_URI:append =3D " ${@ \
-    'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protoco=
l=3Dhttps;branch=3Dmaster;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-=
config' \
+    'git://gitlab.com/benjamin-schilling/cip-kernel-config.git;protocol=3D=
https;branch=3Dbs/mcom;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-con=
fig' \
     if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \
     }"

-SRCREV_cip-kernel-config ?=3D "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
+SRCREV_cip-kernel-config ?=3D "50f7039f6c1486be2f1e1b2ca0ddc300895e44cd"
diff --git a/wic/mcom-x86-efibootguard.wks.in b/wic/mcom-x86-efibootguard.w=
ks.in
new file mode 100644
index 0000000..6382ff7
--- /dev/null
+++ b/wic/mcom-x86-efibootguard.wks.in
@@ -0,0 +1,14 @@
+# short-description: x86 with EFI Boot Guard and SWUpdate
+# long-description: Disk image for x86 machines with EFI Boot Guard and SW=
Update
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.squashfs" -=
-align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0F=
C63DAF-8483-4772-8E79-3D69D8477DE4
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
+
+# home and var are extra partitions
+
+part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --lab=
el home --align 1024  --size 1G --extra-space=3D100M --fsuuid 1f55d66a-40d8=
-11ee-be56-0242ac120002
+part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsuui=
d 96be3374-4258-11ee-be56-0242ac120002
+
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1=
 "
--
2.39.2


--_000_TY3PR01MB1107541CD6CC53A98748546C4C7E32TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Hi Benjamin, <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">The MCOM kernel configs for 5.10.y-cip/x86 are merged to cip-kernel-co=
nfig master branch now.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Could you please send the revised patches for MCOM x86 target.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Probably, you may need to update =1B$B!H=1B(B</span><span lang=3D"EN-U=
S">recipes-kernel/linux/cip-kernel-config.inc=1B$B!I=1B(B file.
</span><span style=3D"font-family:&quot;Aptos&quot;,sans-serif"><o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Thanks &amp; Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Shivanand K<o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-ligatures:none;=
mso-fareast-language:EN-IN">From:</span></b><span lang=3D"EN-US" style=3D"m=
so-ligatures:none;mso-fareast-language:EN-IN"> cip-dev@lists.cip-project.or=
g &lt;cip-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Benjamin Schilling via lists.cip-project.org<br>
<b>Sent:</b> Thursday, May 2, 2024 6:45 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> [cip-dev] [isar-cip-core] [PATCH] Add MCOM x86 target<o:p><=
/o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From edb4f62f1f11252bc82d343251=
30e072825d75ef Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Benjamin Schilling &lt;<a=
 href=3D"mailto:schilling.benjamin@siemens.com">schilling.benjamin@siemens.=
com</a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Wed, 10 Apr 2024 17:21:11=
 +0200<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [isar-cip-core] [PATCH=
] Add MCOM x86 target<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This patch adds the MCOM x86 as=
 another hardware target.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Benjamin Schilli=
ng &lt;<a href=3D"mailto:schilling.benjamin@siemens.com">schilling.benjamin=
@siemens.com</a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kconfig&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 ++++++-<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">conf/machine/mcom-x86.conf&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 15 +++++++++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">kas/board/mcom-x86.yml&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 15 +++++++++++++++<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">recipes-kernel/linux/cip-kernel=
-config.inc |&nbsp; 4 ++--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">wic/mcom-x86-efibootguard.wks.i=
n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 ++++++++=
++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">5 files changed, 52 insertions(=
+), 3 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 conf/machine=
/mcom-x86.conf<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 kas/board/mc=
om-x86.yml<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 wic/mcom-x86=
-efibootguard.wks.in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/Kconfig b/Kconfig<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 7c19640..89f7467 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/Kconfig<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/Kconfig<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -43,6 +43,10 @@ config TARGE=
T_SIMATIC_IPC227E<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Siemens SI=
MATIC IPC227E&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ARCH_AMD64<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+config TARGET_MCOM_X86<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Siemens M-COM X86&quo=
t;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ARCH_AMD64<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">config TARGET_QEMU_ARM64<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;QEMU ARM64=
 (aarch64)&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ARCH_ARM64<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -73,6 +77,7 @@ config KAS_IN=
CLUDE_BOARD<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; string<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/qemu-amd64.yml&quot; if TARGET_QEMU_AMD64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/simatic-ipc227e.yml&quot; if TARGET_SIMATIC_IPC227E<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/board/mcom-x86=
.yml&quot; if TARGET_MCOM_X86<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/qemu-arm64.yml&quot; if TARGET_QEMU_ARM64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/hihope-rzg2m.yml&quot; if TARGET_HIHOPE_RZG2M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/qemu-arm.yml&quot; if TARGET_QEMU_ARM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -190,7 +195,7 @@ if IMAGE_FL=
ASH &amp;&amp; !KERNEL_4_4 &amp;&amp; !KERNEL_4_19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;config IMAGE_SWUPDATE<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;SWUpdate s=
upport for root partition&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on TARGET_QEMU_AMD=
64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TAR=
GET_BBB || ( TARGET_QEMU_RISCV64 &amp;&amp; KERNEL_6_1 ) || TARGET_HIHOPE_R=
ZG2M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on TARGET_QEMU_AMD64 || =
TARGET_SIMATIC_IPC227E || TARGET_MCOM_X86 ||TARGET_QEMU_ARM64 || TARGET_QEM=
U_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 &amp;&amp; KERNEL_6_1 ) || TAR=
GET_HIHOPE_RZG2M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;config IMAGE_SECURE_BOOT<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Secure boo=
t support&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/conf/machine/mcom-=
x86.conf b/conf/machine/mcom-x86.conf<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..21bcd1e<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/conf/machine/mcom-x86.con=
f<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,15 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CIP Core, generic profile<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# Copyright (c) Siemens Mobili=
ty GmbH, 2024<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# SPDX-License-Identifier: MIT=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+DISTRO_ARCH =3D &quot;amd64&qu=
ot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+IMAGE_FSTYPES ?=3D &quot;wic&q=
uot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+WKS_FILE ?=3D &quot;x86_64-gen=
eric.wks&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+IMAGER_INSTALL:wic +=3D &quot;=
${GRUB_BOOTLOADER_INSTALL}&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+USE_CIP_KERNEL_CONFIG =3D &quo=
t;1&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+KERNEL_DEFCONFIG =3D &quot;cip=
-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_mcom_x86_defconfig&q=
uot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/kas/board/mcom-x86=
.yml b/kas/board/mcom-x86.yml<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..28c4674<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/kas/board/mcom-x86.yml<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,15 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CIP Core, generic profile<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# Copyright (c) Siemens Mobili=
ty GmbH, 2024<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# Authors:<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#&nbsp; Benjamin Schilling &lt=
;<a href=3D"mailto:schilling.benjamin@siemens.com">schilling.benjamin@sieme=
ns.com</a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# SPDX-License-Identifier: MIT=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+header:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp; version: 14<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+machine: mcom-x86<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/recipes-kernel/lin=
ux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 40c378b..7acdc0d 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/recipes-kernel/linux/cip-=
kernel-config.inc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/recipes-kernel/linux/cip-=
kernel-config.inc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE">@@ -10,8 +10,8 @@<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"DE">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE">&nbsp;SRC_URI:append =3D &quot; ${=
@ \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE">-&nbsp;&nbsp;&nbsp; 'git://gitlab.=
com/cip-project/cip-kernel/cip-kernel-config.git;protocol=3Dhttps;branch=3D=
master;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config' \<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE">+&nbsp;&nbsp;&nbsp; 'git://gitlab.=
com/benjamin-schilling/cip-kernel-config.git;protocol=3Dhttps;branch=3Dbs/m=
com;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-config' \<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"DE">&nbsp;&nbsp;&nbsp;&nbsp; </span><s=
pan lang=3D"EN-US">if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' =
\<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }&quot=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-SRCREV_cip-kernel-config ?=3D =
&quot;ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+SRCREV_cip-kernel-config ?=3D =
&quot;50f7039f6c1486be2f1e1b2ca0ddc300895e44cd&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/wic/mcom-x86-efibo=
otguard.wks.in b/wic/mcom-x86-efibootguard.wks.in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..6382ff7<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/wic/mcom-x86-efibootguard=
.wks.in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,14 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# short-description: x86 with =
EFI Boot Guard and SWUpdate<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# long-description: Disk image=
 for x86 machines with EFI Boot Guard and SWUpdate<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+include ebg-sysparts.inc<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part --source rawcopy --source=
params &quot;file=3D${IMAGE_FULLNAME}.squashfs&quot; --align 1024 --fixed-s=
ize 1G --uuid &quot;${ABROOTFS_PART_UUID_A}&quot; --part-type 0FC63DAF-8483=
-4772-8E79-3D69D8477DE4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part --source empty --align 10=
24 --fixed-size 1G --uuid &quot;${ABROOTFS_PART_UUID_B}&quot; --part-type 0=
FC63DAF-8483-4772-8E79-3D69D8477DE4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# home and var are extra parti=
tions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part /home --source rootfs --c=
hange-directory=3Dhome --fstype=3Dext4 --label home --align 1024&nbsp; --si=
ze 1G --extra-space=3D100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part /var --fstype=3Dext4 --la=
bel var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242a=
c120002<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+bootloader --ptable gpt --appe=
nd=3D&quot;console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk watch=
dog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1 &quot;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"DE">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE">2.39.2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_TY3PR01MB1107541CD6CC53A98748546C4C7E32TY3PR01MB11075jp_--


