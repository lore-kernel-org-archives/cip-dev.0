Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A4C282DE
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 01:35:14 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.58])
 by mx.groups.io with SMTP id smtpd.web10.242.1741644852584001912
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 15:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hEZb92aO;
 spf=pass (domain: siemens.com, ip: 40.107.249.58, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2j+2ylps6CR7xteYOqDoxeJf4iCvbcbTzRUar4MCl9F71CExtqbqCr9oQLGBD0P8pawgqjron8Ben47e7R0xJ27+iThsDDorIIfoHV3/kYCW80/dHA3zwR3lHisz08ONvDcthjenEEsQV6WsS5vWyx7PjGSxBK3VIuj02uvIb4Yo/rIbGQNYCh616IjmjP9prv2+GxQ9y2mFiPOl0pfRms2WOFNxFG6BK0fX814NyQoTntQzknk53vauaKYOh+hWxd+azotlDACBmC5uPsgECC1XfSZLWZ6Ed9u3RiQfaONPAGfVk3A7V726PbCgkX5iVuqOsAmAiLcuUGWDSkrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwAo06D5mpnV4KT2TDYfnHajUs9dewtu7QTOu0ZvLVY=;
 b=oPNUSMwZZOA32d3T3f29kFLsaaSEZKbKuQan3IC2vPLmoeqXICXHiqyYTUQ+1HTkMX6q7QfDHuC9x165xaWsqg27n1zI6Fz7NQ8A5zSkk999zCACBYlHU5e2p4oKso9W0/z6V/rnizpfT3HpcXMOI6/VJNO2w4xTk1DRJ1cAeMShUkCj+eja+MD8/hng2cYZ0211rGu9q0Hm1EEYxSAamIYxTjw+2nGS93iNB/dWsLgPPE6IwCrFXhF1xOrShdEihiM0FyOloj5GRbjrvJ3h2KHLb/AGKSdNS1lphReQkxAQaeM5YF5wj36LxcSvptn94RoaQU0D04kJXyZ8puG8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwAo06D5mpnV4KT2TDYfnHajUs9dewtu7QTOu0ZvLVY=;
 b=hEZb92aOV6YYSNcLGje3U4bQuW6CToZ/iQt98KewDJj9Vt6QXtqU0hzFqMQLGbsLKV25z5nDG+VK6X50UvhxS97jVo/ABRnyELf8VjX1TmUEXLqk3DH5cVrJb9R8bTwsWd9ePa9Fskdsp8i4wX3K6nZ0dR6FCJsihc6A/0QE/8Y7Sp4ZP+lkwflubY/4YOE03mUrwVQ0s/gou7syYuZjrmpoRWe8XPbdNabqLUeV9Mj46eNxxgo3NLQ1OaVvHAyn7odL/AXV1I61jmdCeMr7GTRUj3D+hRIdkW4nz8MwVBaw856/de+DRmLpcHlV1lpmHwIe/JR1BMtjhYr01qUjfg==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by PAWPR10MB7245.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:14:09 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 22:14:09 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer provider that hooks sign-secure-image
Thread-Topic: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
Thread-Index: 
 AQHbjns5YmpFem/SVkKzaVXtmh0o6LNl/UcAgAAA94CAABsI8IAF8QkAgACw7jCAACH4AIAAGHMQ
Date: Mon, 10 Mar 2025 22:14:09 +0000
Message-ID: 
 <PRAPR10MB5422CF6EE9F9F1525D8F1CFC80D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
 <PRAPR10MB5422A552AB83D38C445E1C4180D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <22f01b35-2d08-4b94-bb72-37d82f3b21be@siemens.com>
In-Reply-To: <22f01b35-2d08-4b94-bb72-37d82f3b21be@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bbc7ddea-09ed-43f1-9f2b-4375e69f9d86;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-10T22:11:02Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|PAWPR10MB7245:EE_
x-ms-office365-filtering-correlation-id: 277a3bd2-d688-4482-747b-08dd6020e15b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WnppVWJENkkza3FrV1YycVdKdFpKa2RqL2xZUGRtV1VjTlJmYXVYWTRzakhC?=
 =?utf-8?B?bkdDQUo2bjVHSUhtVHN2dGtOcVQxRmt0YlVVdE1ON2hwYWVrVWlkd29UZHJ4?=
 =?utf-8?B?YnNSTTZoU0pYUzduaFFYWXhRZndzdFhHbzJXSU1zbU1SZWFHTXJ2aStwc3do?=
 =?utf-8?B?aFY0S2FManp2RHQrTGI1bFRDYWlESE95MnFKK29CUzNHdTEyc2FHbGxlaVc3?=
 =?utf-8?B?eDV4QXJHNE9Id3NDVmNneTBQZmZZZzdVN01zUkhDdHRGK1hlT1liZTFMNWYv?=
 =?utf-8?B?ZWZmQ1VIOWJZV3ducGRDSDNTRFFydDQzdmpxOUhqbmVZZ1ZtdVN3bzd3dU1M?=
 =?utf-8?B?ZE9HUHB4MWZMT3dZVVhLdEVCQ0wrYnN2c2xRTFRDS3F5SzNPb0h2Z2dVWHhD?=
 =?utf-8?B?OExvbTJZTTAzemRjRjAzcERBcGM4RHJKMEV3T0NjOXVlZHkxYkREbzJYTHNZ?=
 =?utf-8?B?OXlIcmVPY21mUUpIbDRjRFZaa3NmTEdLRjRTWFNlcFBvdUN1azN0T3V6S3ZQ?=
 =?utf-8?B?OW9sTHMwbjVqQTJjMHdybS9QVWRVdjlHVy92cGFDTytRYmZKMVNqZHZrL1Y1?=
 =?utf-8?B?a2N5Z2NBNTlOdVpyZmVreG5kWUJSNWxXS0xVeVpsSmNhRFRtN29BeWorbWVZ?=
 =?utf-8?B?b0p0SldJN0FPdTJWZlM2ZGI4RWNjRDlGd3FRWTRldmdrbVVRRG1aUDNkbWgw?=
 =?utf-8?B?dWYzR1ZCZTRKdVlQcGJrZk43ZHJMUDRaWDl5UGwxa283b0dvdEI3MXdIcmxF?=
 =?utf-8?B?U29JemhBcTNRN3V0dDg3SUZnY2xBU3pPekRpMEt6Vm5kbjJBeFV3NWxJbkV6?=
 =?utf-8?B?L0g4Si9QVW1GMGN6ZjVaZzVmSXF0UnovSEUzczJvb1E5UFZlUFU4WTY2V3RT?=
 =?utf-8?B?ZWVwalpPai93L2lsdmZBVkhyVTZHSldhb0JOU1F0czk1VUVGN2ZPbzRmZWR4?=
 =?utf-8?B?MnpHd2hFN013V3FIUForc05Dd2VIY3pPay92WFlYdC9KbmM0WVg0Q0xOa3BP?=
 =?utf-8?B?RTVLdmxCZUx2anhkdm9OR2NpS2VhV0ppZ2RQTHJ1My9SbTN2bjI3UTBrZGZW?=
 =?utf-8?B?OEY5ejJ3WGUwcEtlK0duSVZLTVpvU3lqdExvNCtZRVBiUW9VaUtyNzdWMXl0?=
 =?utf-8?B?U3JaV3JlYzNUZ2tPbjByY09KbFJmSXp5VlhmUDZIMFVSTDh5TkZScmkwTWlT?=
 =?utf-8?B?end0ZU9ieDBYbEpTU3V0RTZFTjNCMG5BWTU1aVR1YTVMdHhjM3AyWUppZGZh?=
 =?utf-8?B?R0xIV1h3TTRzakRCdGZMdVJQOXRZOWdYZGF3akprSjFDVTdqQ09HVjk0ZHBD?=
 =?utf-8?B?Z3paMXhCL2o5Y2E2K2NFRGxZQ0EyK1NkdTdPcUszdXBibm9yZ3NCWktSMnp5?=
 =?utf-8?B?RTdNaDluY2pBWXlSeXVSMlJLb3QyUTRzSUZsL0ZBWE5JeDZjY3ZPMWt3NGxu?=
 =?utf-8?B?RWFwNjdoWFJ2TzVlMC9VTzV0SHlubHJENU0wbkRXeTdoRUF1QVFIUjRlc2tq?=
 =?utf-8?B?c1VHTjQyQTBRODVUOWUzUGc5bVdCRGdxNFlrRDZrVUZUYkI3Sk9GdFd4OS9T?=
 =?utf-8?B?QUhNLytuZ0ovajhLd3BhWjBvdXR4RVRmMDVSL2FkMWltSGl5OFBDV3N4UGZ3?=
 =?utf-8?B?aTI3RnZEbVBDc2dJd01vMW05cVZJNTcrcEgxWDRqY3dEVWVrcVZ1T2c2ZTBj?=
 =?utf-8?B?TWJQYWJzRHhJcUdvOUNUOHJFZkhON05xVW04THZlM2VqcXBLeE5QTkJFUXJw?=
 =?utf-8?B?blYzQVFPQStIeXV5cldOdVpVUmZ1eDMrQ0R2ZHdwL21RVjl5a0VsdFF6V25y?=
 =?utf-8?B?Z2FneEt6d3JyS3Z6bkNzdG9lWGhhc3pHTmZhckZwZUdDTW5abHFZV3J1TWJZ?=
 =?utf-8?B?VDN6Z0FtOVd2cUIrZWdjUEFjVFRHYlBlY1h5blQyeFgySlJtdTZIZm9GWXNs?=
 =?utf-8?Q?YD3zxoSgoxQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bXR0ZUx6U0FwNDJRd1hFZTlnWWFvOUJwOEZENlFjYjBQZ09BTkxVcXdYLzlW?=
 =?utf-8?B?eXBqS2VZMjBEb2VlRVh4bktyKys3RENFdDVPR1pRckNIbXBiYjN6Q0djZXlB?=
 =?utf-8?B?UWsyMFI0K2p5VSt2dTNlVFdrVWRHM0NURVUxTUY1cmpyMWNaY0FmTklUWnho?=
 =?utf-8?B?ZlNtaUxCU0VUZ1pJWGxLUXIzTklXYVRJZitibU9uSFQ3Tm1aR211cUNCUmw1?=
 =?utf-8?B?WTVreFNLWEJocHU2OG95eEpKeWs2V3YrQ2ovK1hCTStOZTNUZFJtUkw0Rldl?=
 =?utf-8?B?QjdxY3dHOVYreUtCbmR1N25uSXh3M1JVUyt5ajBoU2wza1JsNzVNYU85N1Fy?=
 =?utf-8?B?Q2ZBVjZNd2xHdVJoLzhxMm5uaWZ3bnRBQ2VVVVdUVDRDNy9MSlBLR1dhU1I1?=
 =?utf-8?B?Ymh5elZwQnlLTk5hcTBteGNRSk5SR20xck44bG5RVS8xN0VXbndzTkJTNGRj?=
 =?utf-8?B?RGNoSjNsMXlmWU04YWhUa3V5SCs0MHJjMG16Um9iSlpUL3dWbzBHUTRGeW9Q?=
 =?utf-8?B?TDRRQ0FCV2NuSnNmS1V5c3VjRVZwY2ZVRTFrUTJMbEhvd0NLYkRVMXpDZWpY?=
 =?utf-8?B?WDk5bUcxbFBMdmU3T2Q5QVFUOW5qSXlpTTRkL000dFR3WGJQVCtZVEJzajlE?=
 =?utf-8?B?TmJYUGRMam12WXFVRGFYVEpvVVVFWFgwY0JKdUd4Qk5PN1lrUUpnMlFtYlI0?=
 =?utf-8?B?aThvSDF4RS9MN0JBOTVnZU1iN2dsbkhMOGVwdzR3dlYrQnZUNzhscmxtSlJr?=
 =?utf-8?B?aG1ocnlralp3ckpmejFsRjd0ZG5BakFqOWh5ZTkvYkRnQmRLSWhXc0QyT04x?=
 =?utf-8?B?dnFaS285bFpZZDRNT01IdzZZcVVyNVVhV0l4OVYvbGFBUldackNTR21JMmxs?=
 =?utf-8?B?R2MzQWJFUTcySUhCNDY1ZGNydk9vSSthV0tBY1B4a21FWXMyeXpaOFdWZHlz?=
 =?utf-8?B?dExoTHFNTFVHQTRSS1V0SGM4RWJWK3haWUVUOGtoZ0xJVDdUMGhoUFpuNTNE?=
 =?utf-8?B?eDlPTFJEVkt6SVk4citZdnlpT3N1VHR1L2E4aXV0bkRobTFjR2xOeFM2TDZs?=
 =?utf-8?B?OEQ3YW1TSmY3MlIxaVhFWEFKSDVmUEVXdGVWOW5jNUVNNlpvQW03TEQ1ZEw2?=
 =?utf-8?B?Ni9PQitUd1NPWENKQnFkUmMwOHo4bTdxMEk5TFlFODFzMURpMkNjWG13SDFz?=
 =?utf-8?B?V1JCenFQOXMyWmt6RmwwaWRIMFJCZEorTmg0TkozSVo5cTU2c0c3eTlOZjJB?=
 =?utf-8?B?dm9sQjlLU3ZwbDlEUzBOVzkwYmJWQTdjZzJ5elRodjVsZ2prSzRiSW5pd3h4?=
 =?utf-8?B?WXp3clNuMU9sbnlyNEtVZVNhRGJzRFJBbGRLa2ZwcWdwWnlWL29vUWhQL1VF?=
 =?utf-8?B?U0VITW5rSndEMEpsbmV0bHNDeU5naUFaemNac3Rlc2k1cmthMXZkK1hubEhB?=
 =?utf-8?B?enZNc0prekZnRFNuV1NRU1NlNEVqRWxrMlBMaXJ1WlNidVB2Q0xjbVFaZ3Zy?=
 =?utf-8?B?TXNhR0VySFQ3eWFCQXZ4eWNoUzdRbGpMYTJUeWQ4YnlmTkFqRms3TkZvNzUx?=
 =?utf-8?B?Nkp3RUkwODduaTVUa0pLd2tudjRQQ2dRMVZvSythbkNscXh1QlFFOTZ3cnZo?=
 =?utf-8?B?UTJqS3RXcWt0K0ZOVzlrWGlHbXYrdXFKREVPUUxjU2dSMHVVQld1ZEZCQXEx?=
 =?utf-8?B?NU42VXhTWWVMOUYvbDdYTGdoa05NcWlMdmVtSGl2ZzVIOHZFbkVVTEl0UTEw?=
 =?utf-8?B?YkY3T2p5V1NEM05odlVwM1E3eWdESHhFK2lPMVhNelBPWXNQK3pPd05yVWtw?=
 =?utf-8?B?bHNiblhCZ1R0Y29uTm9iTXlrZ3FNdXRpMXZLZGZHRnlIN2t0MEw3cCtrN3No?=
 =?utf-8?B?VVZ0MHpLYnpGclJmbWl5N1pBV3Rud2l0SlYrelhRUWg1cHZqZy81ayt3VGUr?=
 =?utf-8?B?YndCK0RLTllCRStPdFppTjN4V0dnN2Q4UFIyMzhIVGZKcUFlTDNKM0xETkp0?=
 =?utf-8?B?Y1FETUpjS2VHUEJGdXJTZUhsbGZVUGR3R2VsR1JyWlhxQWZEQ2txS2F4YVVj?=
 =?utf-8?B?c3NmNEtZbXNMZWVFL0ZsbE9VYjI5UzVXZHZyS1VLZHFUczM0ajJHUE5XVS9R?=
 =?utf-8?Q?0dvPqeSc8CJSRssAR0xDigXAK?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 277a3bd2-d688-4482-747b-08dd6020e15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 22:14:09.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAT4J+GO7Prj84HHea5/otWNeeWYK4gbofMR/Zhlx7NUEbihSMuPH6DefXUZ8TgdB3v+Bh5ArSActP69tmMBFPmKDJoU+2rL8qnbkgbIuSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7245
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Mar 2025 01:35:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18081

PiBOb3cgd2UgYWxyZWFkeSBoYXZlIHR3byB1c2VycyBvZiB0aGUgc2FtZSBpbnRlcmZhY2UsIGFu
ZCB0aGF0IG5lZWRzIGNvb3JkaW5hdGlvbi4gVGhpcyBjYW4gb25seSBiZSBkb25lIHVwc3RyZWFt
LiBTbyBwcmVzZW50IHlvdXIgbW9kdWxlIHNpZ25pbmcgcHJvY2VkdXJlIGFzIHdlbGwuIERpZCB5
b3UgcGF0Y2ggbGludXgvc2NyaXB0cy9zaWduLWZpbGUuYyBmb3IgdGhhdD8NCg0KTm8sIGJ1dCBp
dCBtYXkgbm90IGJlIG5lY2Vzc2FyeSBzaW5jZSBzaWduLWZpbGUgYWxyZWFkeSBzdXBwb3J0cyBk
ZXRhY2hlZCBzaWduYXR1cmVzLg0KSSd2ZSBpbnRyb2R1Y2VkIGEgc2VwYXJhdGUgYnVpbGQgcHJv
ZmlsZSBmb3IgdGhhdDoNCmh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZy9pc2FyLXVzZXJzL2Mv
UWJTbnRoNkdfXzQNCg0KQmVzdCwNCkdva2hhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS2lzemthLCBKYW4gKEZUIFJQRCBDRUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29t
PiANClNlbnQ6IE1vbmRheSwgTWFyY2ggMTAsIDIwMjUgMjM6NDQNClRvOiDDh2V0aW4sIEfDtmto
YW4gKEZUIEQgRVUgVFIgQyZFKSA8Z29raGFuLmNldGluQHNpZW1lbnMuY29tPjsgY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBHeWxzdG9yZmYsIFF1aXJpbiAoRlQgUlBEIENFRCBP
RVMtREUpIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KU3ViamVjdDogUmU6IFtpc2Fy
LWNpcC1jb3JlXVtQQVRDSF0gZWJnLXNlY3VyZS1ib290LXNpZ25lcjogY29udmVydCB0byBzaWdu
ZXIgcHJvdmlkZXIgdGhhdCBob29rcyBzaWduLXNlY3VyZS1pbWFnZQ0KDQpPbiAxMC4wMy4yNSAy
MDoyMSwgw4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSkgd3JvdGU6DQo+PiBUaGluZ3Mg
SSB3b3VsZCBjaGFuZ2U6DQo+PiAgLSBlYmctc2VjdXJlLWJvb3Qtc2lnbmVyIC0+IGViZy1zaWdu
ZXItcGVzaWduL3Nic2lnbiwNCj4+ICAgIFBSRUZFUlJFRF9QUk9WSURFUiB0byBzZWxlY3QsIGRl
ZmF1bHQgb24gc2JzaWduIGZvciBub3cNCj4+ICAtIHNlY3VyZS1ib290LXNlY3JldHMgLT4gc2Vj
dXJlLWJvb3Qtc2lnbmF0dXJlLXByb3ZpZGVyDQo+PiAgLSBzZWN1cmUtYm9vdC1zaWduYXR1cmUt
cHJvdmlkZXIgc2hvdWxkIGRlbGl2ZXIgYWxsIHdoYXQgaXMgbmVlZGVkIGZvcg0KPj4gICAgYm90
aCB2YXJpYW50czogY2VydHMsIGtleXMgKHdoZXJlIGFwcGxpY2FibGUpLCBjb3JlIHNpZ25pbmcg
c2NyaXB0Ow0KPj4gICAgZm9yIGZpbGUtYmFzZWQga2V5cywgYSBzdGFuZGFyZCBjb3JlIHNjcmlw
dCBzaG91bGQgYmUgcHJvdmlkZWQgdG8gYWxsDQo+PiAgIGltcGxlbWVudGVycw0KPiANCj4gSWYg
Y29yZSBzaWduaW5nIHNjcmlwdCB3b3VsZCBiZSBwYXJ0IG9mIHRoZSBQUk9WSURFUiByZWNpcGVz
LCBtYXliZSwgZmlyc3QgdGhpbmcgY2FuIGJlIHRoZSBmaXhpbmcgb2YgYHNpZ253aXRoYCBwYXJh
bWV0ZXIgb24gdGhlIHdpYyBwbHVnaW4sIGFzIGl0IGlzIGFscmVhZHkgYSBjdXN0b21pemF0aW9u
IGxheWVyIG9mIHRoaXMgY2hhaW4gKGFzIGFscmVhZHkgZG9uZSB3aXRoIHN3dXBkYXRlIGNsYXNz
IGFuZCBzd3VwZGF0ZSBzaWduZXIpLg0KPiBPciwgYXMgeW91IHN0YXRlZCwgSSBhZ3JlZSB0byBo
YXZlIGJvdGggdG9vbHMgYXZhaWxhYmxlIGRlcGVuZGluZyBvbiANCj4gdGhlIG5lZWRzLCBhbmQg
dW50aWwgd2UgZXhwZXJpZW5jZSBwZXNpZ24gZm9yIGEgd2hpbGUgKG9yIG90aGVyIG9wdGlvbnMg
aWYgYXZhaWxhYmxlKSwgd2UgY2FuIGp1c3QgcHJvdmlkZSBvdXIgY29yZSBzaWduZXIgc2NyaXB0
IGZyb20gZG93bnN0cmVhbSBhbmQgZG9uJ3QgdXNlIGV4aXN0aW5nIG9uZSBhcyB0aGVyZSBpcyBu
byBkaXJlY3QgZGVwZW5kZW5jeSB0byBpdCBhcyBvZiBub3cuDQoNCklmIHBlc2lnbiB0dXJucyBv
dXQgdG8gYmUgYWJsZSB0byBvYnNvbGV0ZSBzYnNpZ24gZm9yIG91ciBuZWVkcywgd2Ugd2lsbCBl
dmVudHVhbGx5IGJlIGFibGUgdG8gZHJvcCBvbmUgLSBhbnkgbWF5YmUgZXZlbiBmb2xkZXIgdGhl
IHNpZ25pbmcgdG9vbHMgaW50byB0aGUgd2ljIHBsdWdpbi4gQnV0IHRoYXQncyBub3QgaW4gc2ln
aHQgeWV0Lg0KDQo+IA0KPiBzZWN1cmUtYm9vdC1zZWNyZXRzIGNhbiBiZSByZXZpc2l0ZWQsIHBy
b3ZpZGluZyBvbmx5IHB1YmxpYyBjZXJ0aWZpY2F0ZSBpcyBzdGlsbCBwb3NzaWJsZSBieSBpbXBs
ZW1lbnRpbmcgYW5vdGhlciBwcm92aWRlciwgYnV0IG1ha2luZyBTQl9LRVkgb3B0aW9uYWwsIChv
ciBzZXBhcmF0ZSAta2V5IHByb3ZpZGVyIHBhY2thZ2UpIGNvdWxkIGJlIGFuIG9wdGlvbiBmb3Ig
cmV1c2FiaWxpdHkgb2YgZXhpc3RpbmcgcmVjaXBlcy4NCj4gDQo+IE9uIGRvd25zdHJlYW0sIGFk
ZGl0aW9uYWxseSwgd2UgdXNlIHNlY3VyZS1ib290LXNlY3JldHMgZm9yIHNpZ25pbmcgDQo+IG91
dC1vZi10cmVlIGtlcm5lbCBtb2R1bGVzIChieSBwcm92aWRpbmcgYSBrZXJuZWwgbW9kdWxlIHNp
Z25lciB3aGljaCBkZXBlbmRzIHNlY3VyZS1ib290LXNlY3JldHMpLCBzbyBJIHdvdWxkIHByZWZl
ciB0byBrZWVwIHRoZW0gc2VwYXJhdGVkIGZyb20gdGhlIHNlY3VyZS1ib290LXNpZ25hdHVyZS1w
cm92aWRlciBwYWNrYWdlLg0KDQpOb3cgd2UgYWxyZWFkeSBoYXZlIHR3byB1c2VycyBvZiB0aGUg
c2FtZSBpbnRlcmZhY2UsIGFuZCB0aGF0IG5lZWRzIGNvb3JkaW5hdGlvbi4gVGhpcyBjYW4gb25s
eSBiZSBkb25lIHVwc3RyZWFtLiBTbyBwcmVzZW50IHlvdXIgbW9kdWxlIHNpZ25pbmcgcHJvY2Vk
dXJlIGFzIHdlbGwuIERpZCB5b3UgcGF0Y2ggbGludXgvc2NyaXB0cy9zaWduLWZpbGUuYyBmb3Ig
dGhhdD8NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVz
DQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=

