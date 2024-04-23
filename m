Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11722C16B13
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:36:32 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web11.14247.1713864580311782465
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 02:29:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ALMmD5wK;
 spf=pass (domain: siemens.com, ip: 40.107.20.79, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdZFx110F2JXrag7Ar1Lg79V6mhh6MK9UwGxRG0Sl7lx4Wznn2h4PCC2A/TTbEd4JvwQevF8L3XWeoRtNi8vCUmGJ1KL9ymaX+0k5euhR0NrNCaMZ7jVSYC8bYrpKnyA7U5bBzmMPA5cFmaQZ6psGy6WqOJeCnyRVgfcZ9YuTSbk5O7AEWyYYI6MqmJ09x4VcEjrNsMpZkGSufpw6uqiHZcJGDg5MBpkiVfYZFh7J0n3KTtcV7eDnib1RR5MfAMsoTvz4Xz0ckpO1rYYdtF6VE5lA+pdXTw+AyndclT4qjV65FvqkeaDGE2HHrdhs6dzhpL/ncLidpXDz78XmisrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2h1nFdtBCC7Zeep1VFbSt6pfQ6CgPESrZMD9R/XWOg=;
 b=ogCaPezQJ1NxH7K384fFWaOOhOOWnLwACEVAVZ4ggt1YOCKCZ8Gj7yHT8wVQd4ceTs07bvyObEeRAgn4LLeaxVhJ0RQWrU6sR2vVEvX7E01boIVcXJXbpuhy4ATRFhD8EMHPAEO5pa/EqVp0qkWf2gscQpx4pRNrzV8ZAIYjTP+N7MEDFEzVrXBA2LPx5edDKmeGvxEF/3jLR9v8pSwgkkI6ipZ8m5rYxfMeQ1t6aB1Vyxq21ULAV8CyRNHt4JDb+walN9VFAq1YfePze6lMRymWJB68hLp0qGPR0Zd5pFeIy8y03kB1SWbid5KqFUgTFI/MZAKt1WKp71ROcpiKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2h1nFdtBCC7Zeep1VFbSt6pfQ6CgPESrZMD9R/XWOg=;
 b=ALMmD5wK8Bf8JI4YepsFJ9gv9elKGpIoESr1U780rT5Y27lGmX4S/F0Uw4VlboqpNyKoKc+Tke6r/LCCsaU7HXdol4/hVURjbMV7ha9yBequVtcpHuZ9HPhPRN2RwzKSDQT37IJIE5ZUsidGmiOZNaCcu+BeTcq34GhpDlGwsLklC6eWh0vvfvZzbj4DIr+yUP/FvJ+vz3kN6RWas8e00d1K/k7633axLUCvjLoKPH8Fj6E9+VhwV6grzqKAZxRm4xIEhC9lomTRMO8glgSJyxcUZ9r42BKFwWhT4ykBiip/3FBkqfUAbW/8NarosRYHRBUH/F5DfIJlz9F8opJQeA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB8PR10MB3928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:29:37 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:29:37 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 7/7] README: Add rootfs encryption
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 7/7] README: Add rootfs
 encryption
Thread-Index: AQHalWDCsWZyuGjQ50iFa0cYKuWytw==
Date: Tue, 23 Apr 2024 09:29:37 +0000
Message-ID: <b3c6d71a45dcb090c619413476ed1d206091cb9f.camel@siemens.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
	 <20240422141120.577573-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240422141120.577573-8-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB8PR10MB3928:EE_
x-ms-office365-filtering-correlation-id: 029ae198-2a81-4871-75a8-08dc6377e4d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QlpMYXB5cGxNRDFMYXVtbjhJUmNyQ29PaDcwQktWU0hVSEpNS1UwNXltL3JC?=
 =?utf-8?B?VHZWZDVwTjNrR2t0dWVQK2w1MlBBeHFKRHQ5Q3BIdS9hdGNneXkxVmhLblRJ?=
 =?utf-8?B?R0U0VWVIUzRKeDVJRXFyOC9GUW9ob1lSNkxEL3k2L2hVcEx1RGtYaUQxN1FQ?=
 =?utf-8?B?dHR5dmpxa2hnN2M3OUlNeldDeHBkM2JzWVVmMG5WSEhCWm1mWXdrM25EZXVl?=
 =?utf-8?B?TzV0N1BMZlBjUXBlZC9rMjhSbVJMQ0FSU3hKWjNUdlI1WTdnRjUvQVpKS3pv?=
 =?utf-8?B?Yk5EUFZyQmt5K09wSXBEZWxiUTRvVCtJTFhsYkZWaitsdS9nL0s0S0VlRW0v?=
 =?utf-8?B?UW9Xa3BaYlVDMTFIU25DUlp4azhlMm5kbVpXTlRqOEdsekhLcHFjR0FxTGNW?=
 =?utf-8?B?THNXOUp1WERXb3hHSks0ckJkY1BTOExBUXBNTGxmV2pIN0hPLyttU3MvS0FT?=
 =?utf-8?B?aENNR1B1UDdTbFNvVCtyNWM2Y2JESzNoaWptSGEzeUVHZzJpZDMyVlVPZGhW?=
 =?utf-8?B?NjVhN25XK2dIb3R4Uis0cHM3RWdYTWRPSTZld0ZYTVFscXhpNm5wT2lWZ1Jq?=
 =?utf-8?B?YlZzQlpoZGJGWlBWcVFCdDVhbElJSllnaitUd3hLaWpwL0FvY0RkSXRlUnJC?=
 =?utf-8?B?dUxidU9tR0JoMjh3dG1udzA4UjJjeFRzQzlaVTRac1ZXdjBmeDYxU0RVSUhw?=
 =?utf-8?B?aHlOcFV5aTZPVWQzM29FRlhIQ1hQSi80QlR1WXRHTG1Fc2EvUWJFU2prWlIv?=
 =?utf-8?B?dXp1bmJndzVaSGZTYytOQ2JTaWxlV0s0VlZ1WFJERGVjZHVFVmxhM2s5OE9N?=
 =?utf-8?B?YmNQRFFhZlNtSVpjZ0VNWDMrTDBNWTJBSFdKa0s4Yzh5c2lVU2UrUmJKQWU5?=
 =?utf-8?B?YXZSNUYwNnBDL1lKTWNFRjNtSW1qNVJma2x2VWlHdnRJajhLQVcrZGk2d01C?=
 =?utf-8?B?cFN2elI5bHpQUEZEOC8ySmR4ZDJUTlI4UXZSY29KeHpwS1JZL0FDZU11Titx?=
 =?utf-8?B?QVdJRGo2V0YvcUZWTnJ1NDFkZEtYdEY0c012MmxoRDdJd2FoMDBYQi9VQnJt?=
 =?utf-8?B?a2lFbi9Ra1F1ODlwLzViQm5RTzBGYjB6YU5YL3hUT244b2U0ZUVybllKQTNQ?=
 =?utf-8?B?QjlwdUt3czdOQk8reE5tYURZNWdFNnFJMWNUUEg2bjI0YXVET3krdWpUUGR2?=
 =?utf-8?B?dDVMeXR4UGdoOStvZHduZW9CNnAyeUdaUUgzR0hEYVQ4K3hGNlNENzFmaW5V?=
 =?utf-8?B?S1hKV0FZTTdhZDJuKzlFTXhRMko4UEtyQ1pRUDBmZjhENHBaTzRNK3RyWlhB?=
 =?utf-8?B?ZzZEdGNQNGIzMFpZaHJQYVR6QTNxdFNnVUNFekV6UEhWb3pHbnd0eDNXaUZx?=
 =?utf-8?B?RERkUUJ4a2JSeU1IYzkzb21ITEN2RzdMV2tNVk5Yc0JvMUZpS1E5QTBxOEhz?=
 =?utf-8?B?NnRONG54c1RyYVI0TWs1dHhVbzdvTWp3QkVzbzFSdUs5UE1kOEJFZWkrQTVP?=
 =?utf-8?B?MUg2amdRWDRreVN2OFJKSk93aXk1Y1BBRGk2QTl4S0MrN2cxNm5vTEtmUnQx?=
 =?utf-8?B?MjdIdXFiZ2tjbGpoQlc1K2dUcmk3TSs4bUJ1TDJ0RlcvUHR3QnJaczRIOEF4?=
 =?utf-8?B?SGVoUkgvczRuaW1wL0JxMUVrL2dGaEZYUEVJTTBWQW1JMFdQbWVjVE1VVWRH?=
 =?utf-8?B?L3ZmdUt5MWtxMjdiOHBLY3hLeXFqNHNWdWw1TXlxK2l5RTdjOW5vRXhCYzdp?=
 =?utf-8?B?Z2tQVHB2eEpqZUprcFA4N2ZyT0dIUHVSSVBicW1hMTgzM0UzTEdkUWwzb242?=
 =?utf-8?B?cXBkdHZUS1EyUlNWc01WUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V0N6aWFYVExZUVhQeFA3Z2hMVmNiRGJCSW41UWYrakhFRCtDY3R4ZWhSZmlX?=
 =?utf-8?B?b1pEVTVSRUg2ZFczTXlQSDhsbGFPUElQVjNpcFVuK3RCTVd3YTNKUENlQ2Qr?=
 =?utf-8?B?T2xXTjZJWm12VnFBcmo5UTFzTlJjTyt1Y25Ccmd4TGxWaTNSRER1MGZyRG1H?=
 =?utf-8?B?YlRhS3Z4QkdmOURSeEl6SW9nTHlvRG11REFyeWpRTTJOK2ZmZm5vVzIzTzd3?=
 =?utf-8?B?cWt4VkgzNEx2TldrQVN2RFJYUWd4OUthS1RaaHVod2p3VFFkSWNmT1NScXJz?=
 =?utf-8?B?N3BYdVRLeWFQMTVjZHdxbzROenNRQS9ldVRVSVZPNW80eEtaVHZWbG5uMjhn?=
 =?utf-8?B?WXZ3L1NhU0JMQ1JTdVVKdjlha2pFL1QvR2ZLZzZ3dHlBMG4zZDlDUmljRGQv?=
 =?utf-8?B?ZjdMeWQ1Z1czcXJpRnNOYThLWUdBa0NISVB2OFE3YURYZkhKWVc0WlQ1dlFI?=
 =?utf-8?B?Y2FWdUxxNjZzMFJRN3hWNHJTN2Jkb1lpWUpXeWlLN013VEw0d0o5bVlwWDhz?=
 =?utf-8?B?UEMycjBqK1VBTXBFYjFlalRWa25vWmhtZXVUUm4wUlQ5aHFOeXN0eDMyaWYy?=
 =?utf-8?B?YlpOTjkyMUNoTEUxRmpZWm5tT1JyN0UzZDBCVlVyLzNEZVRIWFBqS1pPMmla?=
 =?utf-8?B?N3g3ZWk3c3FWUVdTQ2JPMmZuanFXOVRHSUI3eGpKUUtYTWJNOGgvQ1JSQnlS?=
 =?utf-8?B?OTJmRGhEOG9wZlEwY1haWk5GTk03bUs0dEQvKzlGdy9HMkVGenF5MWJNNDBL?=
 =?utf-8?B?dkg4SEEzQ3Izcit6Ymo1N1NWUE95K3hUc3NtSjBxZ3lWZm5xbWx3Z0tONW45?=
 =?utf-8?B?OWtJYlZSVG16S3ZSK29Id2o4enZiS0FLdlNmQWduVmIycUcrOE9LOVdpZFA0?=
 =?utf-8?B?UVF2WGl0c1JDZnZ6czBjTkpUWHE4LzUxeGJwREF5VWMzRi9LT2MzbnZ6aERl?=
 =?utf-8?B?WURKeWtJVklid0oxYjlaMllyVUZnL2R3TWRxTzluUHliZ3RTM3QxUzJVOFpP?=
 =?utf-8?B?Sy9BcnlaaXFvWEh4RTBSYjU4V2xLL2IwSGd0ZWFsL21nK0J5VmhCQm41T01p?=
 =?utf-8?B?OVZXZm4yVFNvMWVJZ0N4WElKTzRmZmpWSFFydjNCY0lsTWxrMUdQOVNuRFhs?=
 =?utf-8?B?NDFwRWplUFJJWi9OaVhLeTNmZXVQYWxDTmFudHk5dWN6eEJSMmUwb0xYblVo?=
 =?utf-8?B?cDIwZ0s4QTMvaXBDNThvV0RIb1duZDlZUnY2emxFbWRHZkNzZ3FDTzdYcjZ5?=
 =?utf-8?B?T3NpOUFabWYwQTU5UDVYRFFyc3cwN0cwMXZ3b2RNbmtnTjVXek9BUlltT2tC?=
 =?utf-8?B?ZzkrMkxNK2pzU0RZbUlQaVM4cTlVQ2Z3eDNEZjVTUzB3ZjRRMk9tc1REbUNl?=
 =?utf-8?B?UjVvWmlnUjRaSVFsQWtzam1WNHJIbWtrL09HTG9tUDNYYjB6N21PMFMvR0FF?=
 =?utf-8?B?QjY1TkwyQ2lnQmU4dWhqdFQ4a0xWWlpqSTNFWS9YNkR4YlcyemJNdnlIVy9v?=
 =?utf-8?B?T1lLdk1xRlR0WmNEZm9sUTNOSzY2VFFwQ3pxNklZUW91dXZBcUJQUkhrcHN6?=
 =?utf-8?B?OTJNYXNkM3FaSHBudFd1RjA4eW0zT2xkS1l0QXliV1NQdS9JcHgrQzllcHI0?=
 =?utf-8?B?V283Y2Q5di95K2hYT09KUklWRmtVTmU2OW1UbTJzdm5YZVdhUHBNb2hrV1Vs?=
 =?utf-8?B?OXhaTmdVUHhHMktreUdFSXFmb003ZEhGYWJaZyt4R1gyckN3VDJzNkJwS2gx?=
 =?utf-8?B?bGt6TFVvVm5QdS9WREExek9aRURPSjAvQ0NLaWJVRDVOckNzL0dZbWZLbVI3?=
 =?utf-8?B?MXZCR1Mydk4zMlNReWFkT05kSzRSMzh4ZUxRK0syaHVheG9zVVNHMmcxMmRH?=
 =?utf-8?B?NE5aTExZa3lEVDlxZWtwNHpRZGtIRk5hdTF5WXZ5QjFyb1R0ZVpuVCttMkZn?=
 =?utf-8?B?N1VvV01xYVBaS2VPRjJBek9yRHNYYU5hc28zY2YxWVlyUTZYeCtZU04vUnkr?=
 =?utf-8?B?OFRKMXFGcFFUSHhpYW9KM2R1OWZKaGVtUTdSOWxvTE9vN1BrczJwQzg3ak45?=
 =?utf-8?B?MGRjczM2cVhmODQ0c0V5QkNuZS9URUVaTVJHNE5FUHhSRG53SmxFazVybzJv?=
 =?utf-8?B?YXFKL3hXUTgvMm9vVmNsUXVzM1R6T2szckdTdU1rY1hjeU9wVEJUZEFrWVRF?=
 =?utf-8?B?TmZPVlhZWnYveGpXZEJKUWc3Q0NGUEVaN1FGR3ZUb1oyTmVxV3J2Y04xS0VO?=
 =?utf-8?Q?zJtTQeDN+IiApz8bP5osLQCox+WU6/l9LZEw3bfvBc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 029ae198-2a81-4871-75a8-08dc6377e4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 09:29:37.0326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9lb2grTGALx9VePhGE/C+nKb97sX3Ca4sZ6at++1O9WvmVQlsinkwaLA/NSJz/yh0DNYwRxzfzwrPJ9zT/4aCvEYz66Oe62aVEe91A+i24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3928
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <949DDB72CE004646A662FA8457C73535@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 11:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15735

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDE2OjA5ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQg
fCAxMiArKysrKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUudHBtMi5lbmNyeXB0
aW9uLm1kDQo+IGIvZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQNCj4gaW5kZXggYzVhYzZj
NC4uYTIyOWQ4NiAxMDA2NDQNCj4gLS0tIGEvZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQN
Cj4gKysrIGIvZG9jL1JFQURNRS50cG0yLmVuY3J5cHRpb24ubWQNCj4gQEAgLTQ0LDYgKzQ0LDE2
IEBAIEVhY2ggZW50cnkgdXNlcyB0aGUgc2NoZW1hIGA8cGFydGl0aW9uLQ0KPiBsYWJlbD46PG1v
dW50cG9pbnQ+OjxyZWVuY3J5cHQgb3IgZm9ybWF0Pg0KPiDCoC0gYHJlZW5jcnlwdGAgdXNlcyBg
Y3J5cHRzZXR1cCByZWVuY3J5cHRgIHRvIGVuY3J5cHQgdGhlIGV4aXRpbmcNCj4gY29udGVudCBv
ZiB0aGUgcGFydGl0aW9uLiBUaGlzIHJlZHVjZXMgdGhlIHBhcnRpdGlvbiBieSAzMk1CIGFuZCB0
aGUNCj4gZmlsZSBzeXN0ZW0gYnkgYSBzaW1pbGFyIGFtb3VudA0KPiDCoC0gYGZvcm1hdGAgY3Jl
YXRlcyBhIGVtcHR5IExVS1MgcGFydGl0aW9uIGFuZCBjcmVhdGVzIGEgZmlsZSBzeXN0ZW0NCj4g
ZGVmaW5lZCB3aXRoIHRoZSBzaGVsbCBjb21tYW5kIGdpdmVuIGluDQo+IGBDUllQVF9DUkVBVEVf
RklMRV9TWVNURU1fQ01EYA0KPiDCoA0KPiArIyMjIyBFbmNyeXB0ZWQgcm9vdCBmaWxlIHN5c3Rl
bQ0KPiArDQo+ICtUbyBlbmNyeXB0IHRoZSByb290IGZpbGUgc3lzdGVtIHRoZSB2YXJpYWJsZSBg
Q1JZUFRfUEFSVElUSU9OU2ANCj4gbmVlZHMgdG8gYmUgc2V0IHRvOg0KPiArYGBgDQo+ICtDUllQ
VF9QQVJUSVRJT05TID0gInN5c3RlbWE6OnJlZW5jcnlwdCBzeXN0ZW1iOjpyZWVuY3J5cHQiDQo+
ICtgYGANCj4gK1RoZSBtb3VudHBvaW50IGlzIGVtcHR5IGFzIHRoZSByb290IHBhcnRpdGlvbiBp
cyBtb3VudGVkIGJ5IGFub3RoZXINCj4gaW5pdHJhbWZzIHNlcnZpY2UuDQo+ICtCb3RoIHBhcnRp
dGlvbnMgYXJlIGVuY3J5cHRlZCBkdXJpbmcgZmlyc3QgYm9vdC4gVGhlIGluaXRyYW1mcyBvcGVu
cw0KPiBzeXN0ZW1hIGFuZCBzeXN0ZW1iDQo+ICtkdXJpbmcgYm9vdC4NCg0KRG9lcyB0aGF0IG1l
YW4sIHRoZSAuc3d1IGZpbGUgc3RpbGwgY29udGFpbnMgdGhlIHVuZW5jcnlwdGVkDQpwYXJ0aXRp
b25zPyBPciBhcmUgdGhlc2UgcGFydGl0aW9ucyBlbmNyeXB0ZWQgd2l0aCBhIGZpeGVkIGtleSBh
bmQgcmUtDQplbmNyeXB0ZWQgb24gZmlyc3QgYm9vdD8gSG93IGFyZSB0aGUgaW5pdGlhbCBrZXlz
IGRpc3RyaWJ1dGVkPw0KDQpCZWZvcmUgZG9jdW1lbnRpbmcgdGhlIHRlY2huaWNhbCBkZXRhaWxz
LCBwbGVhc2UgZG9jdW1lbnQgdGhlIGdlbmVyYWwNCmRlcGxveW1lbnQgbW9kZWwsIGdvYWxzIGFu
ZCBub24tZ29hbHMsIGFzIHdlbGwgYXMgc2VjdXJpdHkgYW5kDQpjb25maWRlbnRpYWwgZ3VhcmFu
dGVlcy4NCg0KRm9yIG1lIGl0IGlzIGN1cnJlbnRseSB1bmNsZWFyIHdoaWNoIGtpbmQgb2YgcHJv
YmxlbSB3ZSB3YW50IHRvIHNvbHZlDQp3aXRoIHRoaXMgYXBwcm9hY2guDQoNCkJlc3QgcmVnYXJk
cywNCkZlbGl4DQoNCj4gKw0KPiDCoCMjIyBDUllQVF9DUkVBVEVfRklMRV9TWVNURU1fQ01EDQo+
IMKgDQo+IMKgVGhlIHZhcmlhYmxlIGBDUllQVF9DUkVBVEVfRklMRV9TWVNURU1fQ01EYCBjb250
YWlucyB0aGUgY29tbWFuZCB0bw0KPiBjcmVhdGUgYSBuZXcgZmlsZSBzeXN0ZW0gb24gYSBuZXds
eQ0KPiBAQCAtNTksNyArNjksNyBAQCBiYXNlZCBlbmNyeXB0aW9uOg0KPiDCoCAtIGpxDQo+IMKg
DQo+IMKgIyMgc3RlcHMgdG8gY29udmVydCBjbGV2aXMgdG8gc3lzdGVtZA0KPiAtVGhlIGZvbGxv
d2luZyBzY3JpcHQgc2hvd3MgaG93IHRvIGVucm9sbCBhIHN5c3RlbWQtdHBtMiB0b2tlbiB3aXRo
IGENCj4gZXhpc3Rpbm5nIGNsZXZpcyBiYXNlZCBlbmNyeXB0aW9uOg0KPiArVGhlIGZvbGxvd2lu
ZyBzY3JpcHQgc2hvd3MgaG93IHRvIGVucm9sbCBhIHN5c3RlbWQtdHBtMiB0b2tlbiB3aXRoIGEN
Cj4gZXhpc3RpbmcgY2xldmlzIGJhc2VkIGVuY3J5cHRpb246DQo+IMKgYGBgYmFzaA0KPiDCoGV4
cG9ydCBkZXZpY2U9L2Rldi9zZGE2DQo+IMKgZXhwb3J0IGtleXNsb3Q9JChzdWRvIGNyeXB0c2V0
dXAgbHVrc0R1bXAgIiRkZXZpY2UiIC0tZHVtcC1qc29uLQ0KPiBtZXRhZGF0YSB8IGpxIC1jICcu
dG9rZW5zLltdIHwgc2VsZWN0KCAudHlwZSA9PSAiY2xldmlzIikgfCAua2V5c2xvdHMNCj4gfCBm
aXJzdCcgfCBoZWFkIC1uMSkNCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBF
eHBlcnQgQ2VudGVyDQoNCg0K

