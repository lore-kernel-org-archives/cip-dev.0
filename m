Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C71CE7AA3
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 12:34:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.68])
 by mx.groups.io with SMTP id smtpd.web11.30630.1725614018014834592
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Sep 2024 02:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iv/iA9SP;
 spf=pass (domain: siemens.com, ip: 40.107.21.68, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B91phN4b3OQb21dX9L1Xu0IPZ+oR8gHZFkkpQYQNQlujHaXk5ozUlJa5/aIxydnybJstyIVuxJCo+THvvfbnT/KhJdCTGMGKkl2sSDW1JvbHr/O8TqOt94rZJnZjtxE9/nV+vPzossdOoMhEor5PTVVFDWYYsn3iCDtBkv08RNJp7ngpRIGfZNNndrWD7hl/fKrFBSniXDjm98GAACDl+6c6zjSY6heQfmXIjuqmK2UKvrylNWnflZ9x9M9BPiRoVdThTX5wFIFQFF3UQ4A4ZlIoWSYaMT9ZOEQZtZ+RDkzdYav69L+c6zBnM7P7INCa0xOnLnlpv48kJZBAx2IVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJGGmpxubvbC4PRJ8Bic9fv/LjPxht6zJxXEw4U6jkM=;
 b=YfgmlcfMYXbKdgdmg90ynRqC6+3Lek+zXiPsLBYK9mfabFdiKU86VNa4UKtTUDH6nLgO/kXR/GuBpeFs9rfEsiytkcK6LkBsEp947bd54aRp4SQOqqcSO6iM6X2VPHHwgoBvN20E9WooTmWTd8DOyxOzakn0nxTeEbVjCeBbQj5CLTxcbEu3x9dSNfU47H5HDtdH7t6xcI3nqH6u8iIvtYjxY/RTA8+bSg/Qt5nrum1XM2HbxyMgfqwjhsERG/dJoTvXvR8XZ7S7jONgd+mUfGld5CAw9LhXUcXC8aiSHFrpFoHDUAgPrvu0w9SjbaKFthKJVg3s+eAI0BWw005bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJGGmpxubvbC4PRJ8Bic9fv/LjPxht6zJxXEw4U6jkM=;
 b=iv/iA9SP4lp5BTLYvak3NyuyS941A9Gp+ow3rttnW0W1qLlHcLoIeFtwNzxQymBUnObR7d5PZC71fLOnc0fe1JloydX7Y9sUkcKuWcg9kXDc0M7GVyFHJ0ymjRUQWKo6qx7oweJEhtx2tS75BkI0S/W8MmfBUjmQRDJW3wxYQmrEvOUnkBaYytmRhacaU5YCdqMuvBMitIn/cI8faIn/bYQFW004Nz/csyBvItAC0Dns6q3SAmYx3lJMcshbCU5bg+Hv1OMxRmiyvjRnsc3ZQlGTyTj8dsAs9+Pw3QI1ixVDmfsxji2WdlTSy5ICNkAqC4o0+DZofhSElqmhJPkMzA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI0PR10MB8556.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Fri, 6 Sep
 2024 09:13:33 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 09:13:32 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"developerdong@qq.com" <developerdong@qq.com>
CC: "Dong, Zhi Bin" <ZhiBin.Dong@siemens.com>
Subject: Re: [isar-cip-core][PATCH] refactor(squashfs): prompt for dropping acl
Thread-Topic: [isar-cip-core][PATCH] refactor(squashfs): prompt for dropping
 acl
Thread-Index: AQHbAD0LmKVtjY46ikW6AuBmzYKCbg==
Date: Fri, 6 Sep 2024 09:13:32 +0000
Message-ID: <d96b13c0d1891878bdea3e6a46bc33c14759579e.camel@siemens.com>
References: <tencent_EE69D05C78693B4A0913E07D06A7CF6A2609@qq.com>
In-Reply-To: <tencent_EE69D05C78693B4A0913E07D06A7CF6A2609@qq.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI0PR10MB8556:EE_
x-ms-office365-filtering-correlation-id: 1ebf539a-6520-47cd-0be3-08dcce542e52
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NnRJTzZuY3JTbnZjck02a3hvRS9tdGJVVFVhT29DSjQ2Z25KeGp4Yzh2V2FQ?=
 =?utf-8?B?SEhpakl3amVVajYvSUtvOEpEVG5FRDJlTHBySUF3encvcWFsWVpXUmQ1Q0ps?=
 =?utf-8?B?enRaZGhKTE5LalhnN2ZqNVozcDkycWV6cG45NFZjaGRPRVErWG5NN293OExC?=
 =?utf-8?B?V1F3dWVaZ1F6Y0FEM0VRK3pSM2xhMmFkL29KanJuNHpsR2tVZnpxb0k0c0Rk?=
 =?utf-8?B?b1BuU1VmQm8xYVVGQlZrNlBuOEJCNU4vUTg2Wk1xUTc2aXhEQ1hWN0F5Ymtm?=
 =?utf-8?B?WDdhek4wM1YwL1ZSN0tlSFgvM0hOemRQeHlxb0g3K2VjQm0zclZiOEoybEtT?=
 =?utf-8?B?ZGVxbXZzSXVCTHlkSlJ4aU5WQTBJM29JYTlqaERhTUQ0TXdlaDdRREJ0R29i?=
 =?utf-8?B?a1VGbWs5Vk4vWFRLMGN3UlI2L3VXQVZRQnVsazZqU1NHOE4rOXIvVjhMbjla?=
 =?utf-8?B?MlY2ZnFOTUMzTkx2ZFEzK0szOEMvenp5M3drSlNXcktPMGZubDN6Q3c1cmlJ?=
 =?utf-8?B?OFJyYVh1b2N6bWZ6Q1BoNWdRcEZsNmlSRDlxbkp6a1hKWFhMd3NodWN4K054?=
 =?utf-8?B?eXV2QVNmNERHUFlLQ3loaDUxaTh0MUl1TmIybjRRMHI1V2VyODBUd0psVTh5?=
 =?utf-8?B?UkZOQ0RWK2xrV0Yzb2tiWDRFNW9HMWVFMXNnVk9UcDd0cmo3YXBhRERBQnM4?=
 =?utf-8?B?alBaZi82UkJkQXo0RW41Q3NrSzkxd1VabnZ3SExxSHk5eEd6NEVhaUFZWXpv?=
 =?utf-8?B?SjNXcDBRVXpRdVdIQUhhUkNxZmsrRFZjUGZRdHN6RTdJU051TmN3bFdseTZn?=
 =?utf-8?B?bk1TZVNBTmIzdkZhblNVcUR2Q1hHa1Z2Y3Q5RkYySUszN21sanhVVklHeFlI?=
 =?utf-8?B?N1k3Z1NYY1NwNGdHTWUrMVNGUE1WYzVxTHJZQ1RmYWh3YmRuVyt3Q0R6M3ZV?=
 =?utf-8?B?V0JwY0ZkK2RoZkt2R0s1djZsT1RKK1REd2NrSFZzb1c4MUlIVDlscHFFUExO?=
 =?utf-8?B?R1JpRStXdFQ0Nk5LcVNpZXNCWDZYVWkyeFZFdEErM3FSS3JHVitiUzk4aGpZ?=
 =?utf-8?B?WVpGdG93TXYzL2lKcFVQU3ZVUUkvZVZHL1FNeDFGNGNNWnF6VDhyZWZrOXF0?=
 =?utf-8?B?U2trTy9haTk0UzRnS1BSVFNGdGN2RkNzK2o4UDJYcCtrdU56Ymg1NVZML1A1?=
 =?utf-8?B?djE3K292REtRekNjYUVpMXlxMW5nUy9wdlJFYXRoRmZnK3VsQTZ6bkdac2hR?=
 =?utf-8?B?QjdZQzMzZGpTWXVFR2RINEIzRmMwZ0ZJWE45cExGeGJBd2hiWWNXMmw4VVdW?=
 =?utf-8?B?VFloSmRLcE5IOFZFVEJhQkdHRi82MGliUVhCaTFGUDdweVNHQ2RVNFdsQk9k?=
 =?utf-8?B?aHhBc2hQc1Jja1hRL3BuV2xKZXlteEUydWJNMTBQT3ViZDgxYnFmKzR2dmNU?=
 =?utf-8?B?d0tmNXpMelZ6bGZBM0FjajExRU5OeHVJZStrSHI5YnQ1ZzBGMFRpdU1SUUtt?=
 =?utf-8?B?WGp3UTVkSS9iODJEdjRPbUk5VFJGMUx6elV4OFlHU1BiNkV2TUUyQVFxYnM4?=
 =?utf-8?B?bWo4WkhZbWRrMjY3UVhneEwrd1ZKTHcwM2JyUktEeWhLR2N6RlFTci80K09Y?=
 =?utf-8?B?SmlISFhmWENsRnRFVTJtb1RyR0hiZWpGM1VHR1Z6SXM5WlllOFd6UmxvcXZW?=
 =?utf-8?B?b09yNFBwcEwzM1VyQlRyY0o3VjlZOHArTnhCbjBod01YN0ROQ0pEazFlQmd1?=
 =?utf-8?B?TFNMT0VEUHdxeDViVUxYYkRRbm82alRVMEs4M3oyOWhScUxRK25IMzRtNTM3?=
 =?utf-8?B?eENyYTI0R3ZnWi82bm9TVllDbEdDd2RPVG4reWFFN2tzYjcyMzZSdHVHMC9C?=
 =?utf-8?B?eWRpSUZ4QkdwZytZQlkrZGhWYmc0a0ZERXN3cTJxS1dwb1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S3FtVHVIMlRVUVptTUo4YTdqZDdLUk03V0FmbXdOL09Mck1hMVc3QjMzODl3?=
 =?utf-8?B?M3BqVUFZYUVkL0FWYS9XK1JvNWdnRCtyOVFzbWozRGZzOElVRis0aDQxOXdl?=
 =?utf-8?B?eVBQY2xDRTN4RkpDTksyQS9tclVYdS9lS1cvNUFoQS81R3kycVNONy9oQjVL?=
 =?utf-8?B?OVJNM3QxalhXcFBoQVQwV2VrV3J5VWRNcjZJUmFiMjUyS1h4MjNFN2VyOHI1?=
 =?utf-8?B?dUgwdk1XT3BjdjY5UWVuanNEajRxTEwyRUJlWXMvOTA1RGp0dmx0bGlMZytK?=
 =?utf-8?B?N0FSOHNPRTI4cGlKbm5yN1ZlNVdta2wzZ0dUZUFMdkRHZ1N2N2FqRVVWTzd1?=
 =?utf-8?B?aldDZS93LzJCcW0xYzJRZUc5UWxnWXVLZmdmOWVjM2I2SFpPbVA3Z2RxK01S?=
 =?utf-8?B?dnlTeXVZY0IyejYxVHIxdUxqN0NGeVYrVEI2YllMMDgyN0h3VzI4eFVXVWw2?=
 =?utf-8?B?ai9CRTl1WGZLT3g2U2FidkVRV2JGZWgxNU1MSE5GM2xkVFpDemRxZTVsYXpR?=
 =?utf-8?B?NVdyNWZWSllOSlBKb1FOWHUwc2tRMzZHck5DM3JadVU1VnJRTGlVam9TVitz?=
 =?utf-8?B?V25FcEkrYmtGeGg2cVFHV2w5N0dMa1ZEWDRwUUs0TUx0bDBPOStMdnQrVVB1?=
 =?utf-8?B?VG5WdlQ0OFR1N0lublZVekZNd3pMYUZISVpCRE9PaWllNTlsY3BwZU45eWww?=
 =?utf-8?B?K1JnbzZWTis4VklOYWVJVmNBckpOMXVxWksvWVRsVXFFalI2cDhLbWUxSERP?=
 =?utf-8?B?eFlMeWhNVnNHWnpMV0Iwckp3YXF2OHZIc3d5T3o2aFh3VFJxTXNPZVlDU291?=
 =?utf-8?B?M0RWWjFhTkdDZ1JVU3RiS01pOHZ5MDlLY0NkUEtGZ2l6akdlV0RJakNGcVF6?=
 =?utf-8?B?Tko4YzVFWUUzVUVkVGsxMUVTNVkrNXc3blRyRkc4TWZmbWE1NzkzOFFPNXll?=
 =?utf-8?B?Uk8rcFEvd1RSU05oUzA3TjhzRTR2VTVaenZldDlnT0RPOUxPY3lraXEweEg2?=
 =?utf-8?B?b0Y1dE1JZERZWGVuVXduZlFzVmU3ZmZ5MFVrY1ZPSWpuVHliaDI0QTlVam5J?=
 =?utf-8?B?MVdleGU5OXk5dk51OHpjNDhOa0pYdjhudFMwVDlBM2NsZ1E0QXc2SUh4U0R6?=
 =?utf-8?B?Slg5TnNhaE5HZE1iU2ZZQ3IzOVlIbzRBb0c4ZUxZNm1MQ2hIODZ5cnhKNUFN?=
 =?utf-8?B?SUZpc1hOZ09YNk9kTjBOd1BucGY3Y2RnZG84V3ZHL3UyVHhScVA2ZmJPTnRj?=
 =?utf-8?B?aHdwN00vbGo3eTRtTXhMY3BrRFdZc2ZDQmE5RW1vd0lvd0tqL2ROaTJmamJL?=
 =?utf-8?B?cXl0TFUvVVBJeXRPTzlYOUJUQzJxNmdKdlNySHpZcVozNXZYRHNXS1h4OTZj?=
 =?utf-8?B?cXpKY2FHTlplRlNXTmxETFZwN1RnblhJODhvMUpMTVk2Y3IwMkwxcWRHZlQ1?=
 =?utf-8?B?UVZJSkhrODNnbyt6UGw4a1E1bmtDaXpuZFFMYUx4MHVIS2ZFbC9YbzNqZ29E?=
 =?utf-8?B?amlLeE5hT0NocXVTUGg1WlY2L211TnZldUtObHl2bGovdk5oTWQ0bmtDcGxM?=
 =?utf-8?B?K0JFYW5sRWliOWppQmphSWdheVdZM295bHNuMGVOd0tTbVFKME1CdU15RlBW?=
 =?utf-8?B?U0E5YU1PWWpUd0Y0dkwrYzVPeTIvSGs3T3duME9HZGxVdGx6N1o0eGt4S0lE?=
 =?utf-8?B?WDZSN2dVczJBbm0xNmRCOW5qZlo2N2JJd0ZIWE9CRTROZ3B0cW43eXJSNkVY?=
 =?utf-8?B?ZkxCaEllZnpDRExML2dpRXh5MGEwVDBia2ZJOEdUWmptQlBqUG94TTc3anV3?=
 =?utf-8?B?QVJVcHlnSk9wbk5kWlVpdm85eFBnTG8xMUE2MzErSUExSm85dlFuSHI4aEMy?=
 =?utf-8?B?ZXM3QWZkYTdsanQ4OXBycWdBZkFoaFFRcUhXekdPaUl3Ti9NU0VBT1pyYTMw?=
 =?utf-8?B?bFhBQk9GNTN2WEV1Zk0rdnZWOXoyMUhEUjVNbVBpUEtTajN6MU1TakhtZCsv?=
 =?utf-8?B?UC9MdUJ4VEpMTWlPa3VUWVJEMXdSUm55OTRTcnAxbVc1YTRoYjhZQ2ZFQWNm?=
 =?utf-8?B?NFVJalhieUs1b1JlamMzRmliYk9ZOXhiOThvOWt0dGdpYmQvREVTM1ZIN1NL?=
 =?utf-8?B?UFZjMjNYV250bXl5c0doRWN4eFZlK3pPQ3N4K25RQklpOTJXL3haOFpUWXNx?=
 =?utf-8?B?Um1KVklVVHl2SDJmZGxKRTk1cU9jd0RxbkY2cWJISFNuMEdjU0VwNFNsUFpS?=
 =?utf-8?Q?1osBuG5XJuSNdnK+i+qvGTxeFC8wZkymztomNO+vds=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebf539a-6520-47cd-0be3-08dcce542e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 09:13:32.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw0G508o3O7misyPHWBNZcfLty6CIDxA2/1TWio4FkbsVCxxUL+GGmpRqKufm+nIDajeRGcIzt1+PWncaEBXJl8RzoMGv1vAEYp+HF1DS2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8556
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <877F61DC7B47D446B8614D196F506071@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Sep 2024 12:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16857

T24gRnJpLCAyMDI0LTA5LTA2IGF0IDExOjIyICswODAwLCBkZXZlbG9wZXJkb25nQHFxLmNvbSB3
cm90ZToNCj4gRnJvbTogWmhpYmluIERvbmcgPHpoaWJpbi5kb25nQHNpZW1lbnMuY29tPg0KPiAN
Cj4gQmVjYXVzZSBzcXVhc2hmcyBkb2VzIG5vdCBzdXBwb3J0IEFDTCwgYSBwcm9tcHQgaXMgbmVl
ZGVkIHdoZW4gdGhlDQo+IHNxdWFzaGVkIHBhdGggY29udGFpbnMgQUNMLg0KDQpIaSENCg0KSSB3
b3VsZCByYXRoZXIgc2F5ICJpc3N1ZSBhIHdhcm5pbmcgaW4gY2FzZSBhIHNxdWFzaGVkIHBhdGgg
Y29udGFpbnMgYW4NCkFDTCIuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoaWJpbiBEb25nIDx6
aGliaW4uZG9uZ0BzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgY2xhc3Nlcy9zcXVhc2hmcy5iYmNs
YXNzIHwgMjIgKysrKysrKysrKysrKysrKysrKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMv
c3F1YXNoZnMuYmJjbGFzcyBiL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcw0KPiBpbmRleCBiMzli
ZTBjLi5mYzRjNWQ3IDEwMDY0NA0KPiAtLS0gYS9jbGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MNCj4g
KysrIGIvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+IEBAIC0xLDEwICsxLDExIEBADQo+IMKg
Iw0KPiDCoCMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiDCoCMNCj4gLSMgQ29weXJpZ2h0
IChjKSBTaWVtZW5zIEFHLCAyMDIxLTIwMjMNCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFH
LCAyMDIxLTIwMjQNCj4gwqAjDQo+IMKgIyBBdXRob3JzOg0KPiDCoCPCoCBRdWlyaW4gR3lsc3Rv
cmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiArI8KgIFpoaWJpbiBEb25nIDx6
aGliaW4uZG9uZ0BzaWVtZW5zLmNvbT4NCj4gwqAjDQo+IMKgIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogTUlUDQo+IMKgIw0KPiBAQCAtMjAsNyArMjEsNyBAQCBkZWYgZ2V0X2ZyZWVfbWVtKCk6
DQo+IMKgwqDCoMKgwqDCoMKgwqAgcGFzcw0KPiDCoMKgwqDCoCByZXR1cm4gNCoxMDI0KjEwMjQq
MTAyNMKgICMgNEcNCj4gwqANCj4gLUlNQUdFUl9JTlNUQUxMOnNxdWFzaGZzICs9ICJzcXVhc2hm
cy10b29scyINCj4gK0lNQUdFUl9JTlNUQUxMOnNxdWFzaGZzICs9ICJzcXVhc2hmcy10b29scyBh
Y2wiDQo+IMKgDQo+IMKgU1FVQVNIRlNfRVhDTFVERV9ESVJTID89ICIiDQo+IMKgU1FVQVNIRlNf
Q09OVEVOVCA/PSAiJHtQUF9ST09URlN9Ig0KPiBAQCAtNDUsNiArNDYsMjMgQEAgcHl0aG9uIF9f
YW5vbnltb3VzKCkgew0KPiDCoElNQUdFX0NNRDpzcXVhc2hmc1tkZXBlbmRzXSA9ICIke1BOfTpk
b190cmFuc2Zvcm1fdGVtcGxhdGUiDQo+IMKgSU1BR0VfQ01EOnNxdWFzaGZzW3ZhcmRlcHNleGNs
dWRlXSArPSAiU1FVQVNIRlNfQ1JFQVRJT05fTElNSVRTIg0KPiDCoElNQUdFX0NNRDpzcXVhc2hm
cygpIHsNCj4gK8KgwqDCoCBhY2xfcGF0aHM9JCgke1NVRE9fQ0hST09UfSAvdXNyL2Jpbi9nZXRm
YWNsIC1SIC1zIC1wDQo+ICcke1NRVUFTSEZTX0NPTlRFTlR9JyB8IGdyZXAgJ14jIGZpbGU6JyB8
IGF3ayAne3ByaW50ICQzfScgfCBzZWQNCj4gJ3N8JHtTUVVBU0hGU19DT05URU5UfS98fCcpDQoN
ClRoaXMgY2hlY2sgbG9va3MgcmVhbGx5IGNvc3RseSwgYXMgaXQgb3BlcmF0ZXMgb24gZWFjaCBh
bmQgZXZlcnkgZmlsZQ0KaW4gdGhlIHJvb3Rmcy4NCg0KSSdtIHdvbmRlcmluZyBpZiB3ZSBjYW4g
Z2V0IHRoZSBzYW1lIGluZm9ybWF0aW9uIGZyb20gbWtzcXVhc2hmcw0KaXRzZWxmLiBBbHNvLCBp
ZiBQT1NJWCBBQ0xzIGFyZSBzdXBwb3J0ZWQgZGVwZW5kcyBvbiB0aGUgc3F1YXNoZnMNCnZlcnNp
b24uIFRoZXJlIGlzIHNvbWUgdXBzdHJlYW0gd29yayBbMV0gZ29pbmcgb24gdG8gYWRkIEFDTCBz
dXBwb3J0LA0KYnV0IEkgZG9uJ3Qga25vdyB3aGF0IGFscmVhZHkgaGFzIGJlZW4gaW50ZWdyYXRl
ZC4NCg0KWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE1NDg0MDY2OTQuZ2l0
LmdlbGlhbmd0YW5nQGdtYWlsLmNvbS8NCg0KRmVsaXgNCg0KPiArwqDCoMKgIGluY2x1ZGVfYWNs
X3BhdGhzPSIiDQo+ICvCoMKgwqAgZm9yIHBhdGggaW4gJHthY2xfcGF0aHN9OyBkbw0KPiArwqDC
oMKgwqDCoMKgwqAgZXhjbHVkZT1mYWxzZQ0KPiArwqDCoMKgwqDCoMKgwqAgZm9yIGRpciBpbiAk
e1NRVUFTSEZTX0VYQ0xVREVfRElSU307IGRvDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IFsgIiR7cGF0aCMke2Rpcn0vfSIgIT0gIiR7cGF0aH0iIF07IHRoZW4NCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBleGNsdWRlPXRydWUNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBicmVhaw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaQ0KPiArwqDCoMKg
wqDCoMKgwqAgZG9uZQ0KPiArwqDCoMKgwqDCoMKgwqAgaWYgWyAiJHtleGNsdWRlfSIgPSBmYWxz
ZSBdOyB0aGVuDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluY2x1ZGVfYWNsX3BhdGhzPSIk
e2luY2x1ZGVfYWNsX3BhdGhzfSAke3BhdGh9Ig0KPiArwqDCoMKgwqDCoMKgwqAgZmkNCj4gK8Kg
wqDCoCBkb25lDQo+ICvCoMKgwqAgaWYgWyAtbiAiJHtpbmNsdWRlX2FjbF9wYXRoc30iIF07IHRo
ZW4NCj4gK8KgwqDCoMKgwqDCoMKgIGJid2FybiAiVGhlIEFDTCBvZiBmb2xsb3dpbmcgcGF0aHMg
dW5kZXIgJHtTUVVBU0hGU19DT05URU5UfQ0KPiB3aWxsIGJlIGlnbm9yZWQgYnkgbWtzcXVhc2hm
czogJHtpbmNsdWRlX2FjbF9wYXRoc30iDQo+ICvCoMKgwqAgZmkNCj4gwqDCoMKgwqAgJHtTVURP
X0NIUk9PVH0gL2Jpbi9ta3NxdWFzaGZzIFwNCj4gwqDCoMKgwqDCoMKgwqDCoCAnJHtTUVVBU0hG
U19DT05URU5UfScgJyR7SU1BR0VfRklMRV9DSFJPT1R9JyBcDQo+IMKgwqDCoMKgwqDCoMKgwqAg
LW5vYXBwZW5kICR7U1FVQVNIRlNfQ1JFQVRJT05fTElNSVRTfQ0KPiAke1NRVUFTSEZTX0NSRUFU
SU9OX0FSR1N9DQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENl
bnRlcg0KDQoNCg==

