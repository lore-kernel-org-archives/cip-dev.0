Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A802D5AE73
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 08:42:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.14])
 by mx.groups.io with SMTP id smtpd.web10.67846.1730968953887177023
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 00:42:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Dl3o0FvT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.14, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za7sw9Or+XobIoRPh9/A7xrUOlSHRU2JZLoblbkaGqZkjHkqtoT49E5407zo0nICAb+TIad7aQgbzWajLOw5Qw4IHbPPdWAlF5nukyG9sT3kwm3TKI/CWAVDa/MqWgGKRy0XJryGDJIaLeY40ddcdgfgPgA54C6Zp/Bm7arJew40wdGpvLlnwHv7q7hif0geuEVL+fpnXZxWWmZVZL82wgPxl4OTs70kiDNv+AFu9dqK1ttEnievwt3/RqGsr53Yc9lx4Zk2YSKdkZ6cQEvyWX03AiEc/7HTCfThfEHm2f6VSmiq8mWpUyPQCzWFYsG25L+l96Ya/wVacVg9wVQrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jYhGoq6xaWHCgV+C5N8CNwVSFmuZ9y/noMzxtmy6dc=;
 b=nLLO3s/ySN+RruOZSbzshRrYdnhH2+g0gdR/rwbUVyHF3iIliQlFEgy3qyjcIqgmvPsNOpG7uhqEXdWBr7G30anW6uQXhYoD7rcM+T7tH4rBt/jPixSzEm0zthKglzNHGzTpAcO6QEuzqsOPFg6K2BXlV7iQ+DbrFr2OlfNpkT0oj+gX4o17oYItto/l7DO4DW9xZ+GdymsQR7G1T/H1gvf2ZdchcWvPCNtA/3AGsWr7E7HyHALNsiSLIYsQ625QvyIChY5jY/OnE4f2m/MHLInITh6jp0j0Np4j4jYhCCORgRnA5JTD2gmeT7W+2IsXhYOo+TXMu2z6pj7krq8uxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jYhGoq6xaWHCgV+C5N8CNwVSFmuZ9y/noMzxtmy6dc=;
 b=Dl3o0FvTNz+Ur3+34F3rWp9iK/sDk8xbhHN7TIHyqYLVLKYV4najRqePF3riRMMEBP+71FrqkmDOWAFVGXcCOQYmGFKeILNTsV5qObI7hDIKUrVpVzxmEGHFzPDVLbefWGRU25jeFhXM9UiA4VYKk+rk5xyV6tAJatwp2uO3nVA=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY1PR01MB10723.jpnprd01.prod.outlook.com (2603:1096:400:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:42:27 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 08:42:27 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: Biju Das <biju.das.jz@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "pavel@denx.de" <pavel@denx.de>
Subject: RE: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC, G2UL}
Thread-Topic: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Thread-Index: AQHbMGVr7F+7KsSgHEmfV1HS9lamtrKq8ZOQgAAMb5CAAIK54A==
Date: Thu, 7 Nov 2024 08:42:27 +0000
Message-ID: 
 <OSZPR01MB7019133FC4606EAF59FFBAF3AA5C2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB63881D35836D698E201DE3A4925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OS0PR01MB6388FEA218E9FE28B1791DCB925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388FEA218E9FE28B1791DCB925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TY1PR01MB10723:EE_
x-ms-office365-filtering-correlation-id: 36ce766a-4dfe-4a4f-b001-08dcff081bd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MEc5bjB0bDFIcUlKOG1wSzQxMDYwSERXUThWUEs3NFdnL0EvUjdQU2tm?=
 =?iso-2022-jp?B?MUZLcExFWTAwd1JwQWlTWm1rWmlORGtBTmYvQUdDK0N4WnkwVUNIc216?=
 =?iso-2022-jp?B?cG5uL0ltaG9meUVtd2YzNi9GbkhheVRrVVliWkVlVWg2d1lkaGJEU01s?=
 =?iso-2022-jp?B?c1BvdTBUMHFscVI3aGNoOU1kT2RaWFVnWTVRQndzZlJXWXhrVjRaei8y?=
 =?iso-2022-jp?B?UlpSSEptVEQrK1kxZWVBN1B0ckw4WXVPVzJnZHdSbG9vbDltYVJtMSsx?=
 =?iso-2022-jp?B?MUViYXFNQVF3VDdLNERpYkg4SlhscHFJTFBMcmZtOFkzWEdnVHJoZUdM?=
 =?iso-2022-jp?B?TFF2UjJSV0s5bXZqTWFyWDNsdDBRbmU2T002VmswdWp3dHhBeXRLTy82?=
 =?iso-2022-jp?B?SUppSlgvWkFjSDk5R25DSzN5am44WVMrZTdzbHBTa2o0eDZMK1E1NTkv?=
 =?iso-2022-jp?B?ODlBOWFyd3ZXVmw1U2ViMFllRnQ3aDlUdU4zZHhZT0xUdjBFdjRCcVBl?=
 =?iso-2022-jp?B?OVgxVUdsSml2MmR2dXArOENzM3FWaWhQZjlVMHVnY3YzZmcyVWR3Y0w5?=
 =?iso-2022-jp?B?bVpIeDhSQnZmeVJHSWJnd0c4WTJubHRjbjZxbUdKcVYzbHI2bVRXNUJ3?=
 =?iso-2022-jp?B?NGdiWUt4SVlLd1NHYmQzRXJRVVlTaWJpbk5uK1EyK2hhQ2RlTjlRYnFL?=
 =?iso-2022-jp?B?K1hOZll0ZXZoOVJRdkFDTnZybTVCZUwxRXcra1pVdC81NGc0UWY4Qmo0?=
 =?iso-2022-jp?B?ZEsvM3NNa2dHZGYwYXRlbThlWW4rclNNTURQOEhWQ0ZYR1BscHRsZ2Yw?=
 =?iso-2022-jp?B?Uy9McHBhZ3p3WGNZR3AzMi9LSlRYQTVTY2l0R1RwbytaWm1nNjZUaHFl?=
 =?iso-2022-jp?B?ZitPbkk5eU9kR3Vvdzc3SVVuR1JrV3o5LzdyQ0ZCU2FmbFBGNE5tUWZV?=
 =?iso-2022-jp?B?ZHBJMFpnVE50UGYzR2hXdnhuNytUMytvZEo0Ykd6dkVsWHVTb0h2VkFL?=
 =?iso-2022-jp?B?N1BPRDl4U0xwUTA4c2dDbjBaQ0VWbkc3QzZuNnQ5M1h4eTJpNi8rRXA0?=
 =?iso-2022-jp?B?OURwUDVicCtuQk0rTUpXckR0TXhCc0lENnpWQm5yQ200eC9NNFh0clRl?=
 =?iso-2022-jp?B?ck9jS2xnSjJ6dnp3eFI5RUUycGhHV1NqMHFiWmJjeXZ4Y2pidXB4YmNT?=
 =?iso-2022-jp?B?dzhJYTVoWFNqTDJUbmtVZTA2T2haakljNEVCdGtuY2JuaW1Pdi9YWmJZ?=
 =?iso-2022-jp?B?Nm91Sys0MzdFRU9lQitXWWZJWEFiMHA5YXVUNUZwNGJqUVowbGcwNG9J?=
 =?iso-2022-jp?B?MkZZTkROeEM5Q09DYnF0QkJqa3VHTTRwVG5PWERQcjZMcmhna1hXWjNi?=
 =?iso-2022-jp?B?TysxYkJ6VWNkOVlxNktEQmRZaXBCTjgvZlF5a0RySWVyMFV2WEp6UjRo?=
 =?iso-2022-jp?B?UUlROTV2TnVkZmlpOWgrZlcrMDg1Y2pNbE9XNXhTYitVZGZsTDJ3ejFp?=
 =?iso-2022-jp?B?dE0xSHlWOWM1SEp2MW9hZkZJdjI0RkdPSVgzd0JGbmVRMVZneDFLTWZ2?=
 =?iso-2022-jp?B?OXc5OGhXWHhlYWxRUjNKb0xJKzNETmpjOHBab09lZG1VUGY0a0t0bTlI?=
 =?iso-2022-jp?B?dFFPM2RKZnB5Y3JkR0hjWHRvc2xUNlZIay9lWlZnUW5ycjFaSDlFVENB?=
 =?iso-2022-jp?B?bVZUQTI5cXUyaldNTU9VQ2FOdUdtRUFOVWo2cUt0Z3ZZNGQ5QzJxbVFq?=
 =?iso-2022-jp?B?RjFZNGIvMTBxU0VJMEpYa0tHdkRCSWwwbHlBQW9WRzd6TDM4TWxuMXMw?=
 =?iso-2022-jp?B?RXFYUGRzbHlIRGxQMmRDdnNDbUxrUHJSckRjb2JkOGR2dWI0T0x0QnlV?=
 =?iso-2022-jp?B?NWpPM0RqcTVKR0FpWTc4Nm03aUlwa1MxTmw3MkRVamQxUm5MT29HWG4r?=
 =?iso-2022-jp?B?cjlmRDNLM1JOeCs0TDdjeGdGTDVNcmUxd0phaG9Qb3J2MGwzQWx6M1N5?=
 =?iso-2022-jp?B?ZEhUN2xFeTNCQlc2RzZmUDd4OEoyaA==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aTdZUmorVGlNQXp3eHkyeGlFMnp0SGIwNEtDUTE3eHJMWWFPSjMwQ1FG?=
 =?iso-2022-jp?B?VnhjdStFeHpUdmszbkJTMHpOQW9seWhYSW45M1RjbEFmZnRMK3VGSVVx?=
 =?iso-2022-jp?B?NzRHankxOXc5cWxocnZVQXlRT1czaE52S2pPWkZ2SzdETXN1TFJHSmV6?=
 =?iso-2022-jp?B?eHA1dmNKUmYvcmJoZDR0U3JWeEFDOGxwRGdMektBcGhQYUp6MHF4K0da?=
 =?iso-2022-jp?B?Tmx6dHk5c2dZeWRoak4xZ2Q1UXI0U0RkZzhYSnBKSkM1ZTBnb2ZIbWx4?=
 =?iso-2022-jp?B?Q3l2NGZydzk1dmxVN0VzaDlBVFZ2U3AxYUF3UEQxK1Nhb0JPZ2RHWk5w?=
 =?iso-2022-jp?B?S2ZmeE5ZekZCU2xNbk0yWlFuMzNrRFpRNGpCaGxZSEdCaHNjZ0pZMnRu?=
 =?iso-2022-jp?B?WGRicytIK3l0NW0rZ3lBM0o5NmxmVFBiU0JmSkR6MEpoaTEremUzT3pi?=
 =?iso-2022-jp?B?L0RpeExDS0tuN1IrWmRRRUtLNFFMWFpEUDZVME5qa0poZzMvZTVYcmFM?=
 =?iso-2022-jp?B?dE1xSGd0MUtacm1xOTlnNndDZXdxTzlsOFVzemJ2dzhRRXlLWGoyd1lD?=
 =?iso-2022-jp?B?V0FxTkFPaGVBRktPcnJYaTVlVzBiSXo0MzdRdldraHB1RlV6ZmNqajA5?=
 =?iso-2022-jp?B?SHpSL2puYkgyQjJQNXdDcVUrQTRwaDVmUzd2YUdnYWZHcExoZDNzalNL?=
 =?iso-2022-jp?B?cmtwZ1VUak9RNDRRaEVyenFlQzAxVXp1b01ackV1UERJNkcwRU55cFFI?=
 =?iso-2022-jp?B?bW1JWC9xQm5vUDRwRUFsZjBldHVZY3VuMU1qOTdxSmJBUnROaWovNnBu?=
 =?iso-2022-jp?B?bmlVTkdFQVVucC8vMkxDTUFwVnlOT2svcUc4QmxwRmNvcFBtRXhZdExi?=
 =?iso-2022-jp?B?RTB1Uk9CL2VMZzVaVDlyK1J3RkE5aU5URDQ0OVhvRFVqKzA1akZ3Y1ls?=
 =?iso-2022-jp?B?NUNnbjFRblhuSGRJVHR3WCtzVUNyYUZhK1RpNGc2R25tdllFU1lqaGlp?=
 =?iso-2022-jp?B?c1pvOVRVT2tYeGJlYm1BVXlsR3JoREQ5cmVOK2lXUmJGdTdrRDJHS2dE?=
 =?iso-2022-jp?B?bUh4dzhMaXR0RkRQVEhOeElFbUlrZ1pqekMyN0VSYWhtNVVlWkxhYWV3?=
 =?iso-2022-jp?B?eWpuNnJ3dXNpR0ZBd2RNbVZzK2dta1hyVURoUnZSTzZ1TnRnL3BNOVhY?=
 =?iso-2022-jp?B?ZE5UZTBCTjRaeGJzbGUrYmh2cmVvanAvVENVUUdxQ0RzUW9qanFPSzJB?=
 =?iso-2022-jp?B?SWtJQ3JXRjVlUUF6b3B5MmpvdFdCMmdadldyZG1jOUoyMEMycExDenFB?=
 =?iso-2022-jp?B?SEM5WE8rc3I0eTZjQ3FLOHZ0KzdsamF3ditVVDdoUjV5WGtyV0lkNEFq?=
 =?iso-2022-jp?B?ZC9Ud2NMVExSeWc3MnRES2FSdW02OTNiaWlnMzh4bU40aWtJcm1qTTdh?=
 =?iso-2022-jp?B?bm15aDNWWmhYMzNaeUxQb3lvTkM3VjdGSFp1b2dKNHNncnFaMUV3UFo4?=
 =?iso-2022-jp?B?dW13OGxwS2lNbnBDUW1VMzFoU2JWV0UwSGhTSjRCZnZ3L2haRCt0K0o0?=
 =?iso-2022-jp?B?SW5pMHNVVTlaTkRqUFU2RFNRV1BFbDJYdHRjRDg3dXVJQkJLVmg4c2U0?=
 =?iso-2022-jp?B?bjVVcVU0V1ZNTVFNY09kc0pENThTZnhPenBuclMxV3c4Vy85eE5FK2x4?=
 =?iso-2022-jp?B?UWNHRXFhaDdSSnpCMUpqYWFMQXBKODlRY1FQSUlaZ0x6N0RaQjBuWGs2?=
 =?iso-2022-jp?B?c3Y0dVVrTVFEbWdlaHAyQUR2c0hCN3lySXh3VWc0OXltT0p1Z3ZSaUNY?=
 =?iso-2022-jp?B?TjR6WUh5RHlQMUs2VDNucFlJR2VUdjlld2YrcUJLUHBiZnA1OFdraDU3?=
 =?iso-2022-jp?B?cGFORUZab2ZwQ3BtN3RPVWl3TXhCdm5kR2RDNUVobnRIVFFEdk1Kb3pv?=
 =?iso-2022-jp?B?bXN1Wk1HWDdlMld2dndLVE94Y0VjYzNTUzFwNlFsSWNBT2dPN1N5QmtW?=
 =?iso-2022-jp?B?b2IwcXVhbzVUUXlXWm9wcDZ4K2FnSWp5MkVwYWdiZmtTOE9oV2JHd1dX?=
 =?iso-2022-jp?B?RUU4V1J0NUJBclkzSURQS09yK1krdmZNQ1Vzc0tFVW4zZW5LRGN2RUQ2?=
 =?iso-2022-jp?B?cmNSdTZZRExBdElXS01IWHFqY0FqeHB3UjZFNW42OHJINlZ3OXphNjhR?=
 =?iso-2022-jp?B?YndLZ29naEVtcExjZ1Vzc2VMcmdCT1VWQUFXMkpKT0ZVUkQ0SU5DVmpn?=
 =?iso-2022-jp?B?WmxJTkhHcnlhUXZaN1ZUN0ZCNEFveFM1cEx3TndsZnBuenhlZTQ5ckt2?=
 =?iso-2022-jp?B?V2lhQ09FY1hpYld1OFg3SFNCNjRkYlZIOXA4UlVYMUtzczRTM3hvSnlG?=
 =?iso-2022-jp?B?ckJnbUE9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce766a-4dfe-4a4f-b001-08dcff081bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 08:42:27.1515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+91UTxQAubNqMQYBlBTefR2zOUIEXFwGLsy5k/Jn60drZ2wsr11Au5q5AFbGp1EQWj/C690PtthBD5Ez8oYcH7R/W5us/Rjh5fybxSUoUh7Gc/M/H8QE5tT6gYGr09V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 08:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17196

Hi Iwamatsu-san,

> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 07 November 2024 00:55
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Subject: RE: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC,
> G2UL}
>=20
> Hello,
>=20
> > -----Original Message-----
> > From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""=
#D#I#T!{#O#S#T=1B(B)
> > Sent: Thursday, November 7, 2024 9:15 AM
> > To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: RE: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on
> > RZ/{G2LC, G2UL}
>=20
> [...]
>=20
> > >  .../bindings/media/renesas,rzg2l-cru.yaml     | 35 ++++++++--
> > >  .../bindings/media/renesas,rzg2l-csi2.yaml    |  1 +
> > >  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 69
> > > +++++++++++++++++++
> > >  arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  8 +++
> > > arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  8 +++
> > >  5 files changed, 117 insertions(+), 4 deletions(-)
> >
> > I reviewed this series, there are no problems.
> > I can apply this series, if there are no other comments.
> >
> > Test:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/153062
> > 9245
>=20
> Build fail on RISC-V.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-
> /jobs/8290354547#L2630
>=20
> Lad, please fix this.
>=20
I will investigate and fix this in v2.

Cheers,
Prabhakar

