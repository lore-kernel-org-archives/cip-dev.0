Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF632C021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 05:37:27 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (APC01-PSA-obe.outbound.protection.outlook.com [40.107.255.50])
 by mx.groups.io with SMTP id smtpd.web11.44947.1739770638339430462
 for <cip-dev@lists.cip-project.org>;
 Sun, 16 Feb 2025 21:37:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O44ElxBV;
 spf=pass (domain: siemens.com, ip: 40.107.255.50, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzdvN1BYlHCPy8L1/i8jtF/j7lpJAiz1fAnilpLtSkYbfIMmmk63piBjB+fOJvGEp575C07PadtN4GNTFI3Z1JOMQqCjvVuhasovHDhuJRBkRWnjUyzpV3N4HfkQxwAcyYBHpt1RHJ6QxZgPjzx+j7Cj/f3+aC63Hzw3tFKfouvdQj5QMCPk9jxFv/hPVYJbsAXp3wWRwu++E5QAxi5uqOnhOlMQntSjd7xFBe6TmU1oG2ft0nHFimA/Z2gJ005X2LvB2W5Mm+wnf7xw+GT6BD6vRD2AMJEkX3RkUveHG5tw5ilqmMGUT/blpStsNOSq38H6Y8bIEp+tDRfzRzvDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VAajGuf57vSQwGB5U8wNgKULn9uqPRPd2e292O8EcE=;
 b=ZrgSqZf+T6qMbXNje7r/p7wwIwzsajfRtKxe0qX8iZA3cV6KXVCDmdI8DE+7lhEXlC/qUoBZjC/vA1ds21v0+N0mCyomMhe/k7cABkhQxkGC2mWzmTlz/6FGShsiL0YjCy+x5Kstd5W3Am3O+TAmqnN4j9mcbt3f81q6QkiH0BwpPvUuSsrZtPI1cf180FbDYrRZRFYJobJD/bFl7IuJ0D2RIYuVyq+veaT05gi+j0l2vTE5cpAeVEW3tIlR0stqzZg21gZF7ECHmJD3il6fUM+tSdHA2BimFs6iZ2ViKW10QSpyPmd7/3QaceMDALLA5jAkf+QirQvDrVkt7/O3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VAajGuf57vSQwGB5U8wNgKULn9uqPRPd2e292O8EcE=;
 b=O44ElxBVpjrBcpdKjdGREUAZCxxuUJcv9zzUJpL6aGqi9krFDUzqJeihFD5StYrECHzI4DTLDvi6EF1Paigp3kAyfGixOPi3raUOuNHa9qCZiBER5SV3HjDQtxVXVf/C94ko/gvQsjqGDJsHzI5IvSJAUdYkfWNGfxYQzBG0cHqBipg8B4nMDX5g0A+xxhLdZIiM3CyQB1Dpidyw4adPEHMw6r+lYLqphNCBQWLnn8SSbA6Qy9OnhfauzVWaegFs6pVrRgS8EkiUtANTwsAqN/MkMo1XhYOdWagF/6rb439BXeVm++Tf6QPlCXCGXryAaoPNUJW4+96pxF27rR7Exg==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by PUZPR06MB5818.apcprd06.prod.outlook.com (2603:1096:301:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.8; Mon, 17 Feb
 2025 05:37:10 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%3]) with mapi id 15.20.8466.004; Mon, 17 Feb 2025
 05:37:09 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
Subject: RE: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest
 version
Thread-Topic: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest
 version
Thread-Index: AQHbfqGzndax4yzvFE+i+hf63PwB4bNGdHgAgASJHFA=
Date: Mon, 17 Feb 2025 05:37:09 +0000
Message-ID: 
 <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
 <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
In-Reply-To: <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-17T05:37:06Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=ba590980-f904-4368-adf5-cfd4fab1b0bf;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|PUZPR06MB5818:EE_
x-ms-office365-filtering-correlation-id: 2c956439-a0f9-4259-3ebf-08dd4f151f2d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WGZNVjFJZ3NLMHFieEFOdERtdWxuSDNuU3pBbE1VVnlRNkMydllFYnFsL2Ni?=
 =?utf-8?B?ZDlOQy8rTk9xOWtYUHpUbWlIVFVCbGgyNkY2d1AxdTZEczBlWk9QWHRjMXh0?=
 =?utf-8?B?R2ltT2JCcGNoZnpLU1YzZXM5NUQ4UEtOL29VRzhsM3JaWmRmTFh2aitlbG5y?=
 =?utf-8?B?TFpQN0tDU2dscHVVUUlia0F1bHlVbUNoWXhteFdYY3E0RHlPd2taMHN0dXhC?=
 =?utf-8?B?VVcrb2pXM1R0alcrNDluSWdta1MxaFBKMTBPbWFYZ09VMzI1b1c3TVprR0N5?=
 =?utf-8?B?SDFxc0k4c0t4ZWNNejlFYmEzU2lUdThJYURqa0xibThMTGRVTmpYdENqL1RW?=
 =?utf-8?B?SU1GMFhId0FnY1FoZ05odmgxU1M4NEJlcTI0b0dRMUx3UGtrbTJUTnpQS2hm?=
 =?utf-8?B?eEZCdWRyak84ZjVrb1VqMklPSjRBZm1uNWtlMjEyb3doOXVWOENTa1puTFhB?=
 =?utf-8?B?dzlWdkZteGVhNVFKa3ZDOEhvQ01DcERvUDhhbEZ4dG9GQkxxc05MNk5VZnJl?=
 =?utf-8?B?KzFrUWE4VUlOaVdtaG5hL3NRQnFycWRpdVo3R2ZKYjBQRzRZekl6TytTUURy?=
 =?utf-8?B?WlNycmx4UHJHNVRreWllM2xmdlZqS2JyejkzRWJoeG5PeEVabFVzbWgzcWIv?=
 =?utf-8?B?SFAxYUhJZWQvMnc3dFY1LzRNMlNZTW4yTGlJb1pFd2E5b05lMG5XYUZvSzNh?=
 =?utf-8?B?UVBEQ29xTUpBSTRyRDdSdjdYeDZocDJNbWhZYWpQay8vcFlGTE9CWkwxYXVF?=
 =?utf-8?B?NkJVK0dydnZjMW9ER3hFTWY3c3l4UW9wNTY2RmhJZW5KQmVqMGh0VUg2cWZ2?=
 =?utf-8?B?SGE5SVUrakl1cVdNVy9DOWcxNFV5T25nSnRDY0dWZWlGZU8zRGxzbGdud1BP?=
 =?utf-8?B?d0MrbmZoQVFLUzloemFmd1FudG5UN0JqU0U1QUptWVV5SUtLTTkyOXlhdEMv?=
 =?utf-8?B?ZjQvK092cDFrZngwbjJESnZoY3lIQlhES09vN09tRjJ5MXNqZG50VkkxaGFU?=
 =?utf-8?B?ZUQ2UWF5dE5iOTZWNTFwaGhiaTRSWWxVSzFITXFTL2I5NEdSYzR5d040cVEy?=
 =?utf-8?B?T3lTczdzRUVIdFRBQnI3VFVHc2xxZy9pa2FyTmtaQUFrVUVVcWlRTGlWbmtT?=
 =?utf-8?B?NGxQWHgyMDE2TjZkb0NUUnBraUNkSEhTV0J5czNiOGZlZkNLTjVYeVhzbjg4?=
 =?utf-8?B?cytIQjhzZDA5UUFkUERqU09mYnJvbVROYXJGalRCd091SndoMlppMjIxWm5B?=
 =?utf-8?B?a2R6dWxwcTJHeWdHR0ZqZDlwTEhhQlN5NDFIaWdhSnRvdTg4REhpS0FFRFJy?=
 =?utf-8?B?ZkdGQmZJZ3dWY3hjRkFEOUkrYXRiRGh5VUJNTXZZVWFWcUJaaXBla2lYMVBu?=
 =?utf-8?B?SlNRdUdSeWpKa3daemQxdUx3eHlWQlNid2FYZkM1aDRXbU1pcFRHSlJxbi9V?=
 =?utf-8?B?Tk1icHZEMHF3bUZjUUlkN0FObml5RGtqUEZxMHYzaFZXM1lXTjV6SFpPcnQ4?=
 =?utf-8?B?eW9aZzAyazJGUzFNY2V1T1R2Zko1aEZFaDFvUEtXZk5ZVjFCbUVGVTRoamhH?=
 =?utf-8?B?cG93Uk9zTkhmaCt2aFhyc0loMTNERUdUNlBXelN5Rm50OE92SmVzUzJVMFR6?=
 =?utf-8?B?SmFUcCt0aEdTNnBvM2NEdmV4dGtHcGcyZ09DbllVTlBTdVI0dlRhM3htUFlj?=
 =?utf-8?B?bHFKTVFTcTh2QnRjemxXRkc5RE1hMW9XQUJEYzlkZ1djdnBrSkNzMEJYam1Z?=
 =?utf-8?B?MnVvbnlXNVBmdi9xMUhpeWFoK2h6NWFabVB3andBTk8wMk5yS2Z4RXJ0amdG?=
 =?utf-8?B?MHdtU0g0N2JnYzMvZjlXTktYVWpYbkd5aVNxSVpwbk9WaVBWZTFxZDcvQmlM?=
 =?utf-8?B?S0gzT2s3a0twNVNkZnZnMW1aeHlTV29qMEdIK3FmcjhYN1k2NFlvYW5pbzVj?=
 =?utf-8?Q?QjaRMlg+QFCLlBLC/yT/4pz9b40xgr3d?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RUlKSm0zalJ6VDBwSVQzWGRRcnYwMjlzUXA0UnlEUFlWQWlnNGlKVG13djRR?=
 =?utf-8?B?YnNNN3JSR0lOOXZTbEZKSUtLM21aK3ZzUDU4b1A4d3R5eW1DSHV1OEw1Zk1o?=
 =?utf-8?B?YTFqTi9vZzBNNnVZR2xTQTU3MWhiamsrWCtwSHNIU09NcW1TaGZzYzFaTGJQ?=
 =?utf-8?B?UUY4YS9jN21KZmhlRHZRRHkyQnBxL0pMdUxRdUs5ckJtVTZTT3kxb2JuZnlF?=
 =?utf-8?B?UDN1VGZnVW8rZ01Vd0ovdmJhMFFUdmQrNHBBOGZseVRwaEJRNm9JeUoyTEtE?=
 =?utf-8?B?WkhpM3YzcjlCLzVFeDU1WnZuZWtRbis3TEVJanBlMVF3TURLTHM5UWpVdTN5?=
 =?utf-8?B?RjNkQ3QxdmJSZWovWDd0VnRRU2FDTkhwZm9GNlBxWG45NVRPMTd0NVdWYUg5?=
 =?utf-8?B?TXZkN3JXTHlWeDZiNUxFR3A1R0x4YUc4L2pDZElsa1N5cnpCZ0psb21IRHdH?=
 =?utf-8?B?ZXhrd1lGRjlDQkUyMDBMb0hmVkJnVk9RZ3k5MWdTV1pKMzJPRVdEMDJ1Sjk2?=
 =?utf-8?B?Rzllbzl0djdmUHR2dVEranVSWUd0eFp6NVdlaE1sSGRiZFNyRjBHcUJIa0pI?=
 =?utf-8?B?NnBZeGtpcGM3RDh5YWVFVkFhUmtNSnRJY3djeEtONkdBclUya0lETXVnTGU5?=
 =?utf-8?B?ZUtYd0c4dE8yWEhsTjRNM2s5QVJkSmxDOGdPOExyMStVSzdmUWZEUTZwS1Nq?=
 =?utf-8?B?MW1JZyt2a3hTNFVLYWVISmptTkJWclAvZlJVOHlXVlFPU3hWWmFHb2ZpWDd4?=
 =?utf-8?B?QzBiVXF3TjB5MmJWRlBkMG10QTkzUXFRSU5NQ1RxdStzbGtTa3Z2aDhlMmRR?=
 =?utf-8?B?SVVtRDhxZ3NJbXJBV2diek1DdFRIak16VmZ2VjVzNGF4UTF1UEduT3ZLbUxm?=
 =?utf-8?B?VW9RZ28rTzRFYkN0QTBTdnJIb204MEV4U2pqdWRQbWhUc0R0QVN2MHl2Z3E3?=
 =?utf-8?B?V2xuK2psSG9LNVdUMVRzbGd2YzdidEdicWJ4NDQ2NGI4eHN4U0t1KzdNalNi?=
 =?utf-8?B?UDNBaWdhMTZ4dFA3U0lyU2J4U21weWN1T1NYVHNvNWEzK3BYbkN6SEFXbndK?=
 =?utf-8?B?ZGN5VEFCeGpwa2VGNktGc0ZQR3pzKzdSMERzMER3YzdBZEQxbjllbGd1S0Fq?=
 =?utf-8?B?YkFrekJKdDFTcUpOdzVIRlVYQmRiMS9CMkhIODdGalR4NUxzV0FjSXBkSWlF?=
 =?utf-8?B?U2EvQzVzRlQ3R010Sld6blNUOHlKaGtTaGQvbDUzK1pYUkY5L0NhOWdKNkRS?=
 =?utf-8?B?MnBsUjZLaFNidWIrcVcwd0RoVnhtWlNmcWt4TUpCR1JBNVlqWnZZazlJbUYz?=
 =?utf-8?B?eVRySGFOZy9hamlsNkpNdy9PUnAxcDlmTEJua0JkSzI4RHl1d1pQcmxrTVZR?=
 =?utf-8?B?TCt0WVN1SUlDcVhBTDczYVNlTkdvelliQ1oxVm0yeGJwNWoxZjN1cjJMZXlu?=
 =?utf-8?B?cUZOWm9YZEhBb2ZNZS8zUWlHZU4yT3NGN3dvWGI4YytsWGhEeE9rL1NwejNn?=
 =?utf-8?B?dUMrcW1xL0NES0dJY0phdXBySVJLUEs4bFRSYTdSbXNtSkxRZDY4bG9hc1p2?=
 =?utf-8?B?YjFwYTc2a0xsNUxkM21zMnR4dWNtbk0yeVhSTkdhaDRqSTBwN21zVlNrKytY?=
 =?utf-8?B?c3drZVFyVmhqVUJDS0E3RWFEVDNVamQ1VVBrZnBxZnF3cFoyK2pWZ3hpWWFH?=
 =?utf-8?B?ZUJYVjNPMUdZSm9oVnJVZHUzeXRndCtQRlVDMk56SzZJeFE4OUF6akdmOHdD?=
 =?utf-8?B?M3F0WjU5N0lBNDdOUGZxVTJjWnFXU3Z4b1dRZXArdmhocnhzMTVqMk5KZXZY?=
 =?utf-8?B?Z1JwUlBTclFRNllJWGZqM2Z6c3dXVXVscnI1S3hyalNmbEZ3cCsvUDVzdkdV?=
 =?utf-8?B?NWdkZldxMGRaWWJ3VkhOa0FBbk1QdktxRlFFK0RKRTRMZnBwVS9TTS9QUy80?=
 =?utf-8?B?aTZSbnJLeWFzK3RyUmh0VjJqa3Aycm40UEp5QXpDQjlqd014TkJjY2U3UUpH?=
 =?utf-8?B?cjhZcXpXTUhnSjcwSEplOGtsamFMYkI1VXgrZ2doNkNjd3RMb0NnMnA4ZXly?=
 =?utf-8?B?bkpwb2lPWnJ6Rk0zV2RQMVYxVDdmRlBtYUptOEVpRGdsZ25IeHZrMW83UzRj?=
 =?utf-8?Q?Ag4/rLMRv3NXHchpT1kY89C35?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c956439-a0f9-4259-3ebf-08dd4f151f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 05:37:09.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AwwNDoeVkuc1LT+FHOnSa0W2BGKjcbxnk4sMbpsngks1lxpwD0ZCc4TPjact6lXVjDJTBlD2pedrjmAzgFsbZusMbW/3SnQSaCHBANxrYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5818
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 05:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17849

SGkgSmFuLA0KDQogICAgICAgICAgICAgIFlvdSBtZWFudCB0aGlzIGNpcF9tZXJnZWRfZGVmY29u
ZmlnIGlzIGdlbmVyYXRlZCBvbmU/LCBpbiB0aGF0IGNhc2UsIGlzIHRoaXMgc3VmZmljaWVudCB0
byBlbmFibGUgdGhlIHJlcXVpcmVkIGNvbmZpZ3VyYXRpb24gaW4gc2llbWVuc19pcGMyMjdlX2Rl
ZmNvbmZpZyB0byB1c2UgdGhlIG1va3V0aWwgaW4gSVBDIHRhcmdldHM/LCBQbGVhc2UgcHJvdmlk
ZSB5b3VyIHRob3VnaHRzLg0KDQpNYW55IHRoYW5rcywNClNyaW51DQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBLaXN6a2EsIEphbiAoRlQgUlBEIENFRCkgPGphbi5raXN6a2FA
c2llbWVucy5jb20+IA0KU2VudDogMTQgRmVicnVhcnkgMjAyNSAxMzo0Nw0KVG86IEFyanVuYW4s
IFNyaW51IChGVCBGRFMgQ0VTIExYIFBCVSAyKSA8c3JpbnV2YXNhbi5hQHNpZW1lbnMuY29tPjsg
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IEd5bHN0b3JmZiwgUXVpcmluIChGVCBSUEQgQ0VE
IE9FUy1ERSkgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQpTdWJqZWN0OiBSZTogW2lz
YXItY2lwLWNvcmVdW1BBVENIXSB1cGRhdGUgY2lwLWtlcm5lbC1kZWZjb25maWcgdG8gdGhlIGxh
dGVzdCB2ZXJzaW9uDQoNCk9uIDE0LjAyLjI1IDA2OjMxLCBzcmludXZhc2FuLmFAc2llbWVucy5j
b20gd3JvdGU6DQo+IEZyb206IHNyaW51dmFzYW4gPHNyaW51dmFzYW4uYUBzaWVtZW5zLmNvbT4N
Cj4gDQo+IFRoaXMgcmV2aXNpb24gYnJpbmdzIHRoZSBDT05GSUdfRUZJVkFSX0ZTIHRvIHJlYWQg
dGhlIEVGSSAoRXh0ZW5zaWJsZSANCj4gRmlybXdhcmUgSW50ZXJmYWNlKSB2YXJpYWJsZSBpbmZv
cm1hdGlvbiB2aWEgc3lzZnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBzcmludXZhc2FuIDxzcmlu
dXZhc2FuLmFAc2llbWVucy5jb20+DQo+IC0tLQ0KPiAgcmVjaXBlcy1rZXJuZWwvbGludXgvY2lw
LWtlcm5lbC1jb25maWcuaW5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMta2VybmVs
L2xpbnV4L2NpcC1rZXJuZWwtY29uZmlnLmluYyANCj4gYi9yZWNpcGVzLWtlcm5lbC9saW51eC9j
aXAta2VybmVsLWNvbmZpZy5pbmMNCj4gaW5kZXggNTNiZWU4Zi4uZTc2MTk1NyAxMDA2NDQNCj4g
LS0tIGEvcmVjaXBlcy1rZXJuZWwvbGludXgvY2lwLWtlcm5lbC1jb25maWcuaW5jDQo+ICsrKyBi
L3JlY2lwZXMta2VybmVsL2xpbnV4L2NpcC1rZXJuZWwtY29uZmlnLmluYw0KPiBAQCAtMSw3ICsx
LDcgQEANCj4gICMNCj4gICMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiAgIw0KPiAtIyBD
b3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjItMjAyNA0KPiArIyBDb3B5cmlnaHQgKGMpIFNp
ZW1lbnMgQUcsIDIwMjItMjAyNQ0KPiAgIw0KPiAgIyBBdXRob3JzOg0KPiAgIyAgSmFuIEtpc3pr
YSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gQEAgLTE0LDcgKzE0LDcgQEAgDQo+IFNSQ19VUkk6
YXBwZW5kID0gIiAke0AgXA0KPiAgICAgIGlmIGQuZ2V0VmFyKCdVU0VfQ0lQX0tFUk5FTF9DT05G
SUcnKSA9PSAnMScgZWxzZSAnJyBcDQo+ICAgICAgfSINCj4gIA0KPiAtU1JDUkVWX2NpcC1rZXJu
ZWwtY29uZmlnID89ICJlNDg2YzkzYTkxNmNiNmY3OGI0OTE3YjczNDVlODgxOGY5NjA2OWY5Ig0K
PiArU1JDUkVWX2NpcC1rZXJuZWwtY29uZmlnID89ICI2YjVkYjQ4MGI3YTQzZTAyMTdiMWZhNThm
NDg3ZjBiYjk5Nzc0M2M3Ig0KPiAgDQo+ICBkb19mZXRjaFt2YXJkZXBzXSArPSAiU1JDUkVWX2Np
cC1rZXJuZWwtY29uZmlnIg0KPiAgDQoNCkFyZ2gsIHRoZSBjb21taXQgdG8gY2lwLWtlcm5lbC1j
b25maWcgaXMgYnJva2VuOiBXZSBtdXN0IG5vdCBwYXRjaCB0aGUgbWVyZ2VkIGNvbmZpZ3Mgb25s
eSBhbnltb3JlLCB0aGV5IGFyZSBnZW5lcmF0ZWQuDQoNClF1aXJpbiwgSSBzdXNwZWN0IHRoYXQg
cGxhdGhvbWVfb2JzdngyX2RlZmNvbmZpZydzIGRpc2FibGluZyBvZiB0aGF0IHN3aXRjaCBjYXVz
ZXMgdGhlIG1lcmdlZCBjb25maWcgdG8gdHVybiBpdCBvZmYgYWdhaW4uIEkgdGhvdWdoIHRoYXQg
d2FzIGZpeGVkPw0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9s
b2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==

