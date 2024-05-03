Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE2AC10F16
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 11:47:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web10.9875.1714734476332735137
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 04:07:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qNgWJ3zz;
 spf=pass (domain: siemens.com, ip: 40.107.20.62, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HddSuJBLYJT9Hyik0vxErYvkAwG+yScEYfARMgoBtzjcUXA8ROCGx9LFmJ+YUwoLhu8nVYY/ZWsjwAoZTqBz6RS2GrlFddSeaHTHBGAZXqiUR2eczU9ebN30AZR31iXg3lzs7szvW8Ogwxpc7Jx0Q8oZZHUoTSgEq2dVkEiYHexpbbxR96xLe+JayoIS1wZuLUdhf29zx5izrUzHhMi1wwfqIOafiDkKYssInoz4rxgp2fC6o9S5qrhx5Wxa+DJ1tdS9RCULzZ7BIUAvUrVlav3zhikoaoxzjobi9qpIUPMGDA/T6mzgeMv18FjK3WXXPI2NsHZ+gowt6+B1EfdNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRjAdVIySPh3J7OsDPP8WL8W+5Z/f4fFdYFvNYsTOio=;
 b=FxejOF68zTRbWtquInKj6Swpdor95IotfxJ3W5lIh305pSCfYIL2PHBPPOffhThXfmIHuIlsVFM2HOr0bJw0t1ddab8cCopNmlsHvyybpoEawzRyA1+EO1UxrhVRdcR18zNiHchKstzAHL91gm/SLgmwQ2SxqPqXiXvAnAAEW919rAa8dJSNVVWOfQWjY7EvHmiIbzuMU8etO2JMFlfG+q+4x8d5WdHQ11TU4LxzIbRhBFTw3jbYwbo3vEQu6chyQqdEPA8Mo/vxMkxMCw4ioIZ6dQ7Mb3Azq0IRcFa4yw4s1+KykBgp0NJH+dU244/rCRXwjS7Rj8poxwcllvjOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRjAdVIySPh3J7OsDPP8WL8W+5Z/f4fFdYFvNYsTOio=;
 b=qNgWJ3zzSsLhYk4AA63ESFplVX/j0/KeKr4nFn4JRuY8NNDQZ9k1mkrZSLWqYq52FyGlgme6OEerCSamOqFzli1uqDSHLbjyYb2r1H6FzS66N5Ja/LDs3LnwgVGCNY94c6r1k7YpmKA6kFKCJo2OM0hp/doQp8n/36+/a091MfKn4gznIqvyJ9wNxIsSoMSAEHbZomzbk36h2RiB1GkgX6jb8zThk9qRRRW76aFnEqviKfLeVqgG4wXZ5TRkx6aN84s0oWUQgUO68E4DfBAGORooNk5gJZxa0RCwiIjnlbrlKw1SjDELdoTfaSuq6QVcwEMfbNKLtbxy2IsUqmUNJg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI1PR10MB3614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 11:07:53 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:07:53 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 3/9] initramfs-crypt: Only resize partition if ext* formatted
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4 3/9] initramfs-crypt: Only
 resize partition if ext* formatted
Thread-Index: AQHanHOvvsq04XJThECQONpxAxDK/bGFW2AA
Date: Fri, 3 May 2024 11:07:53 +0000
Message-ID: <a7620188551eba9ce9bd18c6b80ec3ecb11404ef.camel@siemens.com>
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
	 <20240502093240.364093-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240502093240.364093-4-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI1PR10MB3614:EE_
x-ms-office365-filtering-correlation-id: 165a1dfa-d89b-4689-e38e-08dc6b614769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UXNoVDE2cmR1QnltVkJnenE3eFdPRGFJREIzTUM1SmtsaDdxbDhiWDViajRO?=
 =?utf-8?B?VVVwdHE4L25MbFJ0Mi84ZXJZZjFOZjYrdnlCSWlVRXkzWEtnbk5lbXVJVERs?=
 =?utf-8?B?Y3NmdzV4ZUNzMTVxUHY1Y2tLK2dVTllKNEo0YzJRMkdMSmZFWXhvbkRPaVAy?=
 =?utf-8?B?SVdJcmUxRVlyci9vQzdUKy9nbEdGNVhTcmw2Mk50K2hHVk5SdlJRODUxM3ZX?=
 =?utf-8?B?ZCs2TlhPNlhqaUJ2alB6bGVJaFhFR0ZxZHpwa211c2VRd2pjUi9aTjh6eTRP?=
 =?utf-8?B?QTFnUkVteWJHQnhacGxhenFUUlBuMVlrR0xkVWtCcVZpQk1CbTVMRVo4SHBt?=
 =?utf-8?B?V1I2R1JLUEtDSi9KbitRM2o1SzNjTEdwbC9Va2RkSkVMUGswRWpHUFlONk5F?=
 =?utf-8?B?MnNtQlBFSVV6YVJZbHlpMFN3NGt0ZW45Y1F4eTJyVGpDYmx0d0hRckp5U3lX?=
 =?utf-8?B?RFZRVUpySmorcUdCMTNOZ0pLbjA1V1o0RUlaYk5LNHRPV3RZWXZETnV4Y1Mr?=
 =?utf-8?B?NDIwMWo4ODJ1MGhCbXFoTGZRcHNZR1Rxb0pkS0hvMFFXQVh6OU9vakRiZ1RR?=
 =?utf-8?B?alhzaytubVhRS3lmVlhPeFdhMjhjaW1GaEt2RWdRNEtuQjhXYStOdFlEYmtN?=
 =?utf-8?B?dytsbXdTVkFGaTRFdkFyQVFQWHN2dFVKZVBTZG9oNmxKUDFldEZ2eEhpdGN0?=
 =?utf-8?B?YnAycFZReE0yNmpDdnZVc0phRmFsMUhMZVRsT1gwakJLbjRaMXN1ZWo3dk1P?=
 =?utf-8?B?TGMzK1lxbkRObloxQ05NSlZOVjZHZ01LbkQ4RVJzZTE1NnVOSGpEeWIrYWw1?=
 =?utf-8?B?a3lLQ0dMNW9MTGhjN3h5dGs5SS9nRlUyeXQwUzhod096TXlBb2VYZndORVBh?=
 =?utf-8?B?UHJHY3laRjR1NXA2TGZIeFhsT3Jtcnh3eS9KY1FFSFB1RFBnSG5yeS9GbzUy?=
 =?utf-8?B?WTJCL0tZWWp3SThaZzF3Q1pBQkdqZlB2THNFNHRXWk1BM05nN3pTUEFzelFV?=
 =?utf-8?B?MW5YNE9SemVlVlFSUng4Wlk4ZWNkTUJFL3ZGNFcxUVpsYkRGUFY4RnJVQ3pm?=
 =?utf-8?B?Nk1DaFlWRmJQOWhiZWlNbDlvYVk5bGdvN2FQb080UHFWKzFqR1NtTkhiSkRi?=
 =?utf-8?B?bzBwbUsxWTIxUmg2ZVY1SmI1RUxpeU9UdzFWYkpoclUzUWhZRjE5UUZGSEor?=
 =?utf-8?B?aEZhZnIwMDROYlF6bE85WFZneXUvU2hscVU5V1FzTVN1ZFd5VENBMklEWWVV?=
 =?utf-8?B?ZDZlcFJnNHpobUg2Rm9HK09jZnFSRGdxbDB0RVVGRXc1NCtyNFdmZ3RJRlhB?=
 =?utf-8?B?WG5IazY3VUF2MFVEQVkzWmNjR01NVW9ySzVjaVIvb0xBM09kQjZtdDVQWjJC?=
 =?utf-8?B?TnZXVUd2cllhNVAwbk8ya3lsVXlWNDNVakN3aDhLdFFCMTJYSlh5Vnl6US9X?=
 =?utf-8?B?NnFONVg0Z1lsT25GN001Z1g5b0VDR3pxT003YlZFQnIwSUc5NmFjejdrTkpL?=
 =?utf-8?B?L0VxZjcyb1I2N1VJYzlwZWMvbEpsek1UamRLT2RkeXZKQmRIWGV0WHBaVmU5?=
 =?utf-8?B?TWc3V2xmYTBMQjJhaHV2dmVKbGxLc2ZLcWx4RkdBbUZTcVpHSXRKNUx5SXRv?=
 =?utf-8?B?ZURYeUdXWnVlTXFUVVlxTGdxY0VOTDl0d1JrcWJJNlYvYzZnYU9WN0d4LzlJ?=
 =?utf-8?B?dHVjV1pMRitCTlNvanA5YmN3a214cnFsSFlFK2EyWnIzR0xtdU00OElhTW1U?=
 =?utf-8?B?OVNTVEpGS2lGUFRzYzJNOVhLdnZ3czB6N0x6TnhHcElQelcrVTdsT3VIQWtO?=
 =?utf-8?B?ZmZsdFR1aCs2WjB1TGNEZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VEZaNjlRQm4vVzZtMGNoSnBLVW5kSFZVcTNqdkMyVXZMQnZmSXVtMWNkbVE3?=
 =?utf-8?B?YkZxTFNZVGdiRlBKLzhEaXBBQVRPZ25td0drNS9FbXN0Vzc2R0hZOG1kbDV2?=
 =?utf-8?B?Rm1CQTdKZUhqUFlpdHU3dUtWbHZvYW85Tk9uVHYxZHgwcUtKRno2alhDeUNn?=
 =?utf-8?B?S0tqVUJZL2VvM1QzRXlvNWREc1lmYmxOanU5RERIVlN4bVd5cG9GYmV6Wlhu?=
 =?utf-8?B?ck5MZzZQNDJJNkdmR3JMN3F4RlJLcWV2TDBlZDFnMTBVUW8rV2xoNGZpTU9y?=
 =?utf-8?B?cGVPKzM2TWRhWWVua0FrNC9yOENGNDZsS1ZnUWtVNVRZay9aNmYrVzhldUN2?=
 =?utf-8?B?d0xHUTh1Uitsa2J2Wi8vUzlDd1BDTnpGTmxNM3ZUSlJaTjdGYm9neCs4RWxR?=
 =?utf-8?B?STR2R2c3TS8yVjZOb05TV1oyVDl1V1UxNlo5QXV5QmRuTHpmNHFNN0dMSFFv?=
 =?utf-8?B?UFdkWnV5WGJSZG9Ycm4rQWNpaStuc3drR1lhbmhOWk4yQjhISFNHYk05aWVU?=
 =?utf-8?B?anhMb3lqL0NVZFQvWkZLbHA0UHJCYUc3eVRUaWFZbFZBVFN1YStGelZRTGll?=
 =?utf-8?B?UlMwNlBiUml1OFZDMmNUNGVINUhIVktka0poSjQyMUlaMldmQ2JLb2JVelhu?=
 =?utf-8?B?MVhyaEhOUktJM2dqd1QzMTR3bGsrMjZ2V3M0WXd6ZFZHUDUxUFdtc1VrNEFI?=
 =?utf-8?B?R2RJT09QQjJ1bWo1UXBhZUhQSXZwQ3EzUnUvWkY5M1JseTAwanRwNDh5dlBi?=
 =?utf-8?B?dnFraHdJbGRHYVdXZUVQMW8vM0I3Y0wyNUhKcllSWnhVTGhlT1JNNTlvVW1n?=
 =?utf-8?B?U3h3Q2lGeUNUT3FuSjF6OStMNkhwa3ZMdmlCVlc4SFhXL3ZmcmFOQ3o3SUdw?=
 =?utf-8?B?ZXI4RHRBQldYbXpISXVnSFA0WG1kRW9OTlN2QlBHbk5TUnRaOCtYNWkvSW5q?=
 =?utf-8?B?VndiTnNaZyt1VEJqNGRpUmhUS2F4WER6NlBFUm1JKy9JVDZFZnUrb0Fyck9B?=
 =?utf-8?B?K0RLUjYzbkVSM0ZDL2FlMlcrYWE5d05iMXltb2YrcE5seCtnbnZ6a3BFZjB4?=
 =?utf-8?B?RHpIZ3NTUDRudm1wQU9GWk94U1llSjNkbDl3WWxPcmJLdjJvTnp5dUg0RVVP?=
 =?utf-8?B?SHNhQlV3L0krTjFYOHdRMHMzTXJRb0lHSTFVY3ZrQUpSb2Vrc1VkYnRDN1JL?=
 =?utf-8?B?WS9xTzlPWVZrRmR5eERWVUtOYVYvSDcvSzhsWW9PcWRjbmJUL3Z1aHdXdllO?=
 =?utf-8?B?QzJHUHF1aFR5b1hJMmhQcjA5TWdPcEM1bTJuaEd0RUxYQ0k5ei9oNFczOXJv?=
 =?utf-8?B?K2NsNnhrcWFwei9FbUp4L0V0K1pXTjhEYmZCOVdyOGxQb3gwK0RNSktIM0py?=
 =?utf-8?B?SlZHV25DSXBwb0E3bFdFeHVqQUswZGp5VFhnTlpVMUx0SVpRL2dHSVBIZ1Y3?=
 =?utf-8?B?MmpHZU1Tcm0xeDBZY3ZnZm5xQU5lN3F5TWxRWGYzODV1ZU5qRHBKcFh4Z2Qv?=
 =?utf-8?B?d2Fob01vVGRreGNIeXdiYTd5dzBGRVFSb2tWQmkzeUdaQ0RRTzhDNGFFMWRM?=
 =?utf-8?B?YXR3K1M5blhVOU9NUWJNVVFLWlUxMC9iNXIvbjVrQmpPU2lkRFVRZjBYcE5t?=
 =?utf-8?B?Y1UyWlZrMURuTDVsNFRCWFg1QTllTlowT1JyV0s2RkhjMVdMVG9OSHArMTdM?=
 =?utf-8?B?aWxtR0hzVkk1THB6MG5KYXdNWGNPM0NXNnJxODE0eHdTdHpSdjcxTmRPb2hF?=
 =?utf-8?B?ellrdHpGYU9WYkxzMkVvYXBhMW95Q2ZWZGYvcEs5dG9ZRzZsdE9WVmNkWUIw?=
 =?utf-8?B?RE5TNXptaVVqTHRLbkxENDNzUDdxWDl1blBwOFJqSC81VGdGNUdnLytoM1c3?=
 =?utf-8?B?NS9QMDZ2dmlKc21SN1BTK3FRWDRaSys1ZkE2WDl0RHNGRUNCM3QxMVN5dXAy?=
 =?utf-8?B?czh6OFYrZUJYMGFFOTVVOSt4d2Yxb08yREo0Y2s4bm9CbTBuMTl3ZzU5UlE2?=
 =?utf-8?B?WTFQUmFDeXVsbkpzS0FibEZralN4T2xGYngrVHpQOHNYQlZBQTQzK0RGNk9h?=
 =?utf-8?B?WXFSUVdmbG15dTd4VVJRSVM2b2NtZFhpSzl3RUlUWXBIVXcrQ3o1T2lDaG5Z?=
 =?utf-8?B?b2YyQ3AvbU9QSFdPTVRNQmRiUGNtYWJPQnRaek1pSEFUTjNpclZiZTFnQ2h1?=
 =?utf-8?B?bkxKM3BmZGZwUVNRSWE2eFVZT0gwVUIwRFBWNmZxcXB1c0tBSkxoM05jRUVw?=
 =?utf-8?Q?Z2hjnfkGn0fYMEG+5j1SA9eCEqR1ohL6Fx0w4fC2SI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 165a1dfa-d89b-4689-e38e-08dc6b614769
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 11:07:53.3628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH9bHeUBb0jEAfk45efbX0sKTKmPTt3qtslHgvPNp7piFykDNY6/QWXV/o3sKhG/ze2xubZ1bzQx+hjHCUlWm53gYBXVoIKVbZvuDUGIAKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3614
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ABCAFB11291514191CC47DA903D6D30@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 11:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15817

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDExOjMxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Ogo+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+
Cj4gCj4gc3F1YXNoZnMgb3IgZW1wdHkgcGFydGl0aW9uIGNhbm5vdCBiZSByZXNpemVkIHdpdGgg
cmVzaXplMmZzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5n
eWxzdG9yZmZAc2llbWVucy5jb20+Cj4gLS0tCj4gwqAuLi4vZmlsZXMvZW5jcnlwdF9wYXJ0aXRp
b24uc2NyaXB0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKysrKysrKy0tCj4g
LS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtCj4gaG9v
ay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zY3JpcHQgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0
cmFtZnMtCj4gY3J5cHQtaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zY3JpcHQKPiBpbmRl
eCA4ZjZjYmY2Li41MWM4MWYzIDEwMDY0NAo+IC0tLSBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRy
YW1mcy1jcnlwdC0KPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnNjcmlwdAo+ICsrKyBi
L3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0KPiBob29rL2ZpbGVzL2VuY3J5cHRf
cGFydGl0aW9uLnNjcmlwdAo+IEBAIC02NCwxNCArNjQsMjYgQEAgc2VydmljZV93YXRjaGRvZygp
IHsKPiDCoHJlZW5jcnlwdF9leGlzdGluZ19wYXJ0aXRpb24oKSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oHBhcnRfc2l6ZV9ibG9ja3M9IiQoY2F0IC9zeXMvY2xhc3MvYmxvY2svIiQoYXdrIC12IGRldj0i
JDEiCj4gJ0JFR0lOe3NwbGl0KGRldixhLCIvIik7IHByaW50IGFbM119JyApIi9zaXplKSIKPiDC
oMKgwqDCoMKgwqDCoMKgIyByZWR1Y2UgdGhlIGZpbGVzeXN0ZW0gYW5kIHBhcnRpdGlvbiBieSAz
Mk0gdG8gZml0IHRoZSBMVUtTCj4gaGVhZGVyCj4gK8KgwqDCoMKgwqDCoMKgcGFydGl0aW9uX2Zz
dHlwZT0kKGdldF9mc3R5cGUgIiR7MX0iKQo+IMKgwqDCoMKgwqDCoMKgwqByZWR1Y2VfZGV2aWNl
X3NpemU9MzI3NjgKPiDCoMKgwqDCoMKgwqDCoMKgcmVkdWNlZF9zaXplPSIkKGV4cHIgIiRwYXJ0
X3NpemVfYmxvY2tzIiAtIDY1NTM2ICkiCj4gwqDCoMKgwqDCoMKgwqDCoHJlZHVjZWRfc2l6ZV9p
bl9ieXRlPSIkKGV4cHIgIiRyZWR1Y2VkX3NpemUiIFwqIDUxMikiCj4gwqDCoMKgwqDCoMKgwqDC
oHJlZHVjZWRfc2l6ZV9pbl9rYj0iJChleHByICIkcmVkdWNlZF9zaXplX2luX2J5dGUiIC8gMTAy
NClLIgo+IC3CoMKgwqDCoMKgwqDCoGUyZnNjayAtZiAiJDEiCj4gLcKgwqDCoMKgwqDCoMKgaWYg
ISByZXNpemUyZnMgIiQxIiAiJHtyZWR1Y2VkX3NpemVfaW5fa2J9IjsgdGhlbgo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYW5pYyAicmVlbmNyeXB0aW9uIG9mIGZpbGVzeXN0ZW0g
JDEgY2Fubm90Cj4gY29udGludWUhIgo+IC3CoMKgwqDCoMKgwqDCoGZpCj4gK8KgwqDCoMKgwqDC
oMKgY2FzZSAkcGFydGl0aW9uX2ZzdHlwZSBpbgo+ICvCoMKgwqDCoMKgwqDCoGV4dCopCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCMgcmVkdWNlIHRoZSBmaWxlc3lzdGVtIGFuZCBw
YXJ0aXRpb24gYnkgMzJNIHRvIGZpdAo+IHRoZSBMVUtTIGhlYWRlcgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlMmZzY2sgLWYgIiQxIgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAhIHJlc2l6ZTJmcyAiJDEiICIke3JlZHVjZWRfc2l6ZV9pbl9rYn0iOyB0aGVu
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYW5pYyAi
cmVlbmNyeXB0aW9uIG9mIGZpbGVzeXN0ZW0gJDEgY2Fubm90Cj4gY29udGludWUhIgo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmaQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqA7Owo+ICvCoMKgwqDCoMKgwqDCoHNxdWFzaGZzfCIiKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBlY2hvICJza2lwIGRpc2sgcmVzaXplIGFzIGl0IG5vdCBzdXBwb3J0IG9y
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1eIGl0IGlzIG5v
dCBzdXBwb3J0ZWQKCkZlbGl4Cgo+IHVubmVjZXNzYXJ5IGZvciBmc3R5cGU6ICckcGFydGl0aW9u
X2ZzdHlwZSciCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDs7Cj4gK8KgwqDCoMKg
wqDCoMKgKikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFuaWMgImNhbm5vdCBy
ZXNpemUgcGFyaXRpb24uIHVuc3VwcG9ydCBmc3R5cGU6Cj4gJHBhcnRpdGlvbl9mc3R5cGUiCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDs7Cj4gK8KgwqDCoMKgwqDCoMKgZXNhYwo+
IMKgwqDCoMKgwqDCoMKgwqBpZiBbIC14IC91c3Ivc2Jpbi9jcnlwdHNldHVwLXJlZW5jcnlwdCBd
OyB0aGVuCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvdXNyL3NiaW4vY3J5cHRz
ZXR1cC1yZWVuY3J5cHQgLS1uZXcgLS1yZWR1Y2UtZGV2aWNlLQo+IHNpemUgIiRyZWR1Y2VfZGV2
aWNlX3NpemUiayAiJDEiIDwgIiQyIgo+IMKgwqDCoMKgwqDCoMKgwqBlbHNlCgotLSAKU2llbWVu
cyBBRywgVGVjaG5vbG9neQpMaW51eCBFeHBlcnQgQ2VudGVyCgoK

