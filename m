Return-Path: <ludwig.nussel@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEFC02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 15:10:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web10.18102.1739373033048528309
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 07:10:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DiJ1R+w+;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: ludwig.nussel@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um1uzSSX5tZ1iXXu397JBY/TJAlbxW+F7HESVL/58qEVhVJeSwfBxkxGy8kA6ljKA6eKdzB3HK2RwTfs8boawCY6pZe6HShW0r1tjJjSrg52/Y2J0zfTIsmZJ+0cp76dFcqagd3d+G1cehpgRBlHDn4Cq/+jocv8U00J+WCCoen5012wlQ/hWT2w4r/YZ2aVE+rFwFa5dq/6z6ieuxP2YlD/QISazVMFg4Kc78cuAg34C6Aie+/pp4zd3oQx7kEIRiCnYCV9jU4nwz/UWPYo0XrI15AykIs4AVQ0H0pq8FCh0inddrY3BZAEc9fKfFmfarbN9wFveS3Sa+PXpcL5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMnhbsr0kfZ5oGKuLQsksJrZwCMzdQnmRLF5ev857yI=;
 b=KfVTA1zRodob/jJpRSKmLg4riF6tpGLWoufw76xSn3NlT1tm3zOHYSZLcTkkFhSCpE5GCW5Ms8dSAy7oRBelWQBZkt3ljoZ+MX4qlL5C58UDdB5/PG347IqIibVBB5WLJdVdbIEeWQalWYt0NzjmpFmuPe6XplWjHIT2OuSXVk3P3CRpdhdzOWKywehe3fZ8sUeCbnXNs0QTvQS1f+tcnAjZf2teATdFsQwEF2xqJyfku2JZMyx9NWt2NXsr4YyE3KvAgAjxjDxrn5Qr7EOhHjkztAnz6tpI4Yn9gX9i0kdLy961to547IYyugqdSOLncKRAyQwmtJUcwvdyKZVUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMnhbsr0kfZ5oGKuLQsksJrZwCMzdQnmRLF5ev857yI=;
 b=DiJ1R+w+pJ3vcXRTJYE3M6KOEIaudoGcBZUU7e5iZkHJDn6Z5yKYvNkT8aSWMk5SzO4AYvxDrPDAsWhqfuvrrTkj33GPN61ydYoZUaQAs5dGJEPCnjRrF58co+xXFVlwKV1zQHrM7InXTwbVXMCyBmTbnYZcxL5UcRDkxzN2fDS7BEEncqosLcSu3z3Eis83GJq9pXTuDeN9wFhGjKQrZe+NUI5vn8A8PlNyEE78to4ZA72+aoTBOknWRQqvzLEdaGjzQOwtKb+JcuYe55pwFMClqy8+h4h4Ng6CZwxggP9Oj8Rf/xV+GYL7tSLvoQEmLj/4sAzoQlvd3G+xj0Hefw==
Received: from DB9PR10MB7124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::20)
 by DU0PR10MB6874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Wed, 12 Feb
 2025 15:10:30 +0000
Received: from DB9PR10MB7124.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6bcf:5290:7bc9:4934]) by DB9PR10MB7124.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6bcf:5290:7bc9:4934%5]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 15:10:30 +0000
From: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 3/4] add move-homedir-var package
Thread-Topic: [cip-dev][isar-cip-core][RFC 3/4] add move-homedir-var package
Thread-Index: AQHbfGIjOWKRH38McEaGxbIHjtpMy7NDx7yA
Date: Wed, 12 Feb 2025 15:10:29 +0000
Message-ID: <59220d65f1b3b4c9e1207d890f73cb25b9ab3bb3.camel@siemens.com>
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
	 <20250211085125.22154-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250211085125.22154-4-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB7124:EE_|DU0PR10MB6874:EE_
x-ms-office365-filtering-correlation-id: f1dd01dd-247c-4a1c-358e-08dd4b776395
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QTA5L215UTlKMEhONWttK01tVFhyVmpuZEljRUNoemZ5TTBBS3lVb1VWV00x?=
 =?utf-8?B?UWJtYUpnUTZ4eGZITXhSWkxEaWozUzA1RG42OEdONlJlWXZDRllsV1dnK2pN?=
 =?utf-8?B?RzBKeThDRjJ6UUpmTVZseDNCUjNZM2JKRE9IUWdndzdEeGVWa016RE81SE4w?=
 =?utf-8?B?djRQN1hqejl0emxpQ3hOQ0dCb3BxMU1MK3pFMFVnM25ueXQrVmlSNTdEdVpu?=
 =?utf-8?B?VEdQVmx1TWJaemYwMG1kN3hnaitObXZWeFpsL1MvR21JTldOMGkveitWRkR4?=
 =?utf-8?B?S0Qrc1NxT1JOdjhHbVliOVp6UnFJazFLMk5GWFUrQ2tQUVB6MEQxNFA5S2Fk?=
 =?utf-8?B?Tm1NNEZTUDBrSlNrck1UY0JWWWZpM3RmZ0lEMnpQbFc4RkU2b3AvM2VGNDd6?=
 =?utf-8?B?Q0dlR2pzREdTME1sdTZ1V2p0c2tNSUZ5b2V5dzZjMUlEeFFITkkwcHVDMnU0?=
 =?utf-8?B?dHkzMlNyZk1GMWtERXJmeWZEa3J2WGk2aWVxYlFreXhmMnZ5ZzcvTm9PTlpt?=
 =?utf-8?B?UDVNZlVaeERGYUJsNWNzeVRPcVJ1cE0vdVlmUW9zVEQ0MmRZQW5zMFVXdlZ6?=
 =?utf-8?B?RWxGWHJ1b1BaNE5FUVV1eEduMlBBYW1DZk5rTWpQa2txNmtUa093QjlzeHA5?=
 =?utf-8?B?S0hMalNBZFE3dFNZSHhBK09LMDltU2VhbWJ4RnVWL0xoMDYxZU1NRTJhWkRH?=
 =?utf-8?B?V09QcFVtVldMTnRPR25rblpVTDRoejFtcFdSYXo2ZjNUQzZoQWpUQ3Z4Mm5Y?=
 =?utf-8?B?eW5ydWpFNFhqSDNRM2lMUmlIV2hWdFJGMmxxanArdjV4N0VlT0wvaVAxdkc5?=
 =?utf-8?B?OGd6ZnA0YjZRSXRBc0JTaDkydUk5T1k5L2g0VU41TUZ3b1YramNMS2tibXYx?=
 =?utf-8?B?aVRtMWhNM2tVU0tXT2Z6SnJrc2NvTTY5L2xEVGRLaWJQUjYyMEVUTHZocWxO?=
 =?utf-8?B?cmZjSFdaT05MRi9rZzUzeTFFRjZabzdBTW1yVlVmSzRnTFNtVU1XMnkveDNu?=
 =?utf-8?B?NERZd0ZmVUN1azFvK09MM3doczFlemJWYis5VXVoRTJyUXdZQVdHcXFCQ29B?=
 =?utf-8?B?Q1dKc1ZjNU9qMHlCZmpiQXZGUkpEUG5jOGZlbFJXamhyWTVpSEdINlNCR1Jr?=
 =?utf-8?B?RFdrY3IwWEM0SlQyc2VVR0puc1MwVnRiYlMzaHV0anZyZEU2SDd3YXdYdWFM?=
 =?utf-8?B?WklFV3Q2bDJuTFVCMU9RTG1WSGhJcmFrTTFEQ0tqMWVnU2s5djBMemtLc0F0?=
 =?utf-8?B?ek9nNFMwdFJkeG43QW50TDNjaVpaQXpHSUsyZmZJNHZvaVllaG5iYzBKV3pz?=
 =?utf-8?B?WnNENE1RMmZ5OWRrSzJ3VGkxb2ZZMktVWUZHdmorMks0K3JWQzVoTGZRSWR2?=
 =?utf-8?B?SE1LbitYR3hiOWx4Q0FtbzVSZHFvZjMwUFUvNmQrMTAvdWVUODQvR1gvOGxE?=
 =?utf-8?B?U2pyZVFJd1F2TVRjTWp1cWI4aWcyNDJaSFVRZlFYUTBGWEVTbWdNajZKSlA2?=
 =?utf-8?B?M1dudE1SOWJJeDZSOTF3SEJlWk4xRExmTlVIOTVDTUtUZU0vcFpUamVKRUsw?=
 =?utf-8?B?TkhNWDV5Qno2ZGRrcHJnam9YNEVuQk1KQzhGRlIwbVYvQXNkRjBBeCthNWRO?=
 =?utf-8?B?clR6cThvUitKQzJzV1VUU1ZIYlU3RGpxVlRhS1R3UlI3d1lRN2VkV1pBMVJQ?=
 =?utf-8?B?V250Ly80NHJCRzRYcEd4dFEweW41eWtvYU9TZmh3ckV3NE8yZzVVcVFsdXFG?=
 =?utf-8?B?UzdQSlB5L1k5MEFWemN2b2dLRHF1L1BWQ3Ywc2J6aCsyYURiVVBEdmpDbFJL?=
 =?utf-8?B?a08vZGJSKzY0c3pvcTk2bXIzekltNjkycUhQYng2d3ZoTkIxN1JuYXlaWmta?=
 =?utf-8?Q?xeSJQ6I44nad/?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7124.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SmNxY2xENDM4NkMvUlJreVdXcDRVM0l2dWxzbDRsSWlLdVdiWloraHE0YmFw?=
 =?utf-8?B?cFlJYTJXRHNUTnFNOVNpcktkejIwQmxCUCs2eEZtdjBNdUtvVnNTN1Y3QUpP?=
 =?utf-8?B?ZHpHV2JmRVFzVnVHYWtHakhCYktHL1RnUkJ5UWFvQVl6M2JUN1liaitpVDFX?=
 =?utf-8?B?VjZaa29rakpsVUxlOEhPVTVXby9rRks4RkNxWmZnSlNTeEpSMjZtVVZEbVJY?=
 =?utf-8?B?Ti9DZ016QjlvMmRraGxwcEFBTzE1M1YrbVJhb1dYb25qbmpWVU50VysxV05N?=
 =?utf-8?B?Tk5KR2M4bWZTR0ZtNzNma3lJeEFsZUxaaDJ3MVcrNGIvVUZRYXVIdFpaNUQv?=
 =?utf-8?B?YkhFZjJKRXlybVNKZnZjYjZuQ0p4RzluWE1YVUc1Wjl6N1lTZkM5dVdlVW5y?=
 =?utf-8?B?bGkxQmpjLzZWLzlRT3RWK1hZajdCYmRvL3R0VCtKbFcxSDhRaWtDdHdoMm9C?=
 =?utf-8?B?Z3IxWUhIOEYvVGxRWTh0ZVU1TmtCTXJKR2ExR0N5UVRFUU85VjVWdk1qVTlj?=
 =?utf-8?B?ZEk5MDZGbGpVUm1IYXdkNExRTXcyRDNmNFlOaUlJNWhwWC9vbDUza3BGK2lC?=
 =?utf-8?B?RnluTGhRaWZCWTVvWUlZRzB5RWtEOUF4TmRERmFtUkJhV3U3dzN1THBoS3FK?=
 =?utf-8?B?em1icURLUklhRUZ4QWYybnVXY0NzY2drSVB2NjhZYXZZeWxkTFVrOGliRFZa?=
 =?utf-8?B?TENlYVRjWDhVK1BuSE9FN2R2MnBaUWpmME5EMmVIQWVvekJ3eUwrNSthYm9W?=
 =?utf-8?B?aHRaUE1UV3JxM24wbDZhTHVEbThKUTBEMjh5UGVnQlpMdVJMTU16NWpMN2sz?=
 =?utf-8?B?OUlORGtaamd3SHNtam1kYi9RNlJoaUJtdEdVQnlvdDFxUStIMGNDVit2SEVR?=
 =?utf-8?B?d1Y0TmhGTEdhZWFzUUx1VnAwUGJ1L2JZMXFiSTUrb1Z4MmhxZDVMM3dqaEha?=
 =?utf-8?B?ZW9UNktOL0t1NFB2b25lTmdENFpVQ2lwQlRNS1lSSGZBazBieitGV3JTOFlG?=
 =?utf-8?B?STU3NlczYWRqdlkrdHBaL2lTSTNINDNIRXdoT3FRVzEzT2pxTTVXWkd2UXhC?=
 =?utf-8?B?dmFTMXJQQkhpNWNrM2JRNjU5NmJCQWxwRGprVUxXVzdFWk5oa0IwcnhOd3k2?=
 =?utf-8?B?RDJ3M1lVa04zc21PaHcrNlJMTlNXbmZ6MlVyc3FlUWtYRU9kNHZSWFFXNVgx?=
 =?utf-8?B?WktZOGhCODR6b2ZkZ3Z6dXdPaEk3VFA5TWY0TkdGZklheTFad2JzWURaUGRy?=
 =?utf-8?B?NTY0MGdnbkc0UFZSY1BFN3J6MVhRRUl4ZEhWYmh3UHdieWFpNzNWa0ZDWjVZ?=
 =?utf-8?B?dEFEYW50d1duTDFpSzl2N0Noam1JZmF0cEtWQjVvZFhLQ3gvWWVQa1ZlMU1N?=
 =?utf-8?B?cmRQcC81M0lDYW1aTzR6YmlnNkY2KzlLZWFZSWxkQUl4VXJRWVBZL2c5eWNE?=
 =?utf-8?B?TEFNR3drdUxzMG1DYjZkNERGSHZ2T3MrdnNpRzRUUWNIR3Q2L3RqakltMHZJ?=
 =?utf-8?B?ZWlCblk4Y2ZKeFA4TkgwdXZqR1U5aVhVNUdOTlRSbWI3bHV0M0h2NUsxc1Np?=
 =?utf-8?B?MDF5eHhmRjJmWHBadkE0UXVwUTFGS0kxSXlyZ1Z1YXFrSzYvTmw1S3J6Z3dO?=
 =?utf-8?B?TlVhVnB2bXgxWXk0Qm9aVFN2M1dSZW13elU3VklteXdyWDliQ0NxaGlINVdt?=
 =?utf-8?B?Sm5JVlM4end6OUtoVEhoeVlxemJETjlnWmxIek9UcWJFZzdNenZWOStaYm1O?=
 =?utf-8?B?cFo0U0oxbTRlN3FsMHZJMkg5RkU5WXVzc2o1UlBrY0Z1bWlqWmdPSWFCMjJj?=
 =?utf-8?B?dzQ2d21QclZ5OXJjNXd5cTNHYncrNGhtNjVjNmw5OHFhWjM5Q001K0ZmQUxq?=
 =?utf-8?B?cG5NbXpjYjk1ck55UmM3N3BVR2pyWjFFZEhJckc4SGVFUHFvcGpWY2ljSzg3?=
 =?utf-8?B?MVI0UFNmRzBRUURpWEYvRzFrMTdYWFI5Mnp1Y1l1TVN5enlLM3hYQnFnQmN2?=
 =?utf-8?B?eFE2N1JMc3hHalo4VUdQdFZGWWdzcWtDZDRVRDBGMkoxdHE3TUJCdWRNdnN1?=
 =?utf-8?B?a3RjbEhtY2s3bThCNUw5MGdLTkVkcHpDdmNLM3pESnY0WTA0ckZaSk5weFcx?=
 =?utf-8?B?WkF5Q2xNTUZkU0FTT1lNeHVzS1UyeXprSVpyelhEUi9WK09JTXoyd0x3R0xz?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAB52D06ACC1D247BCABB0E7E2DE389A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7124.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dd01dd-247c-4a1c-358e-08dd4b776395
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 15:10:30.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7J2lWS90WsOrNOtlU2YZWGsVa8bp7VyzXZRiCx/uJg5ZW17e0s3kW43fxuGEc39PU1X8ofH0MoYwJnIJ/FTEzQSX7nLHckCXaZ0SJfZ6YZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Feb 2025 15:10:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17816

T24gVHVlLCAyMDI1LTAyLTExIGF0IDA5OjQ5ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBjcmVhdGVzIGEgdG1wZmlsZXMgdG8gY29weSAvdXNyL3NoYXJlL2ltbXV0
YWJsZS1kYXRhL2hvbWUgdG8gL3Zhcg0KPiBBbHNvIHRoZSByZWNpcGUgbW92ZXMgL2hvbWUgdG8g
L3Zhci9ob21lIGFuZCBjcmVhdGVzIGEgc3ltYm9saWMgbGluaw0KPiBiZXR3ZWVuIHRoZW0uDQoN
CkZXSVcgZm9yIHRoaXMga2luZCBvZiBzdHVmZiBzeXN0ZW1kIHVzZXMgL3Vzci9zaGFyZS9mYWN0
b3J5LyBieQ0KZGVmYXVsdC4gSXMgYW55b25lIGFjdHVhbGx5IGNyZWF0aW5nIGltYWdlcyB3aXRo
IG5vbi1zeXN0ZW0gdXNlcnMgdGhhdA0KaGF2ZSBmaWxlcyBpbiB0aGVpciBob21lPyBTb3VuZHMg
bGlrZSBiYWQgcHJhY3RpY2UgdG8gbWUgYXQgbGVhc3QuDQoNCmN1DQpMdWR3aWcNCg0KLS0gDQoo
b18gTHVkd2lnIE51c3NlbA0KLy9cIFNpZW1lbnMgQUcgLyBTSSBFIFImRCBJT1QNClZfL18gd3d3
LnNpZW1lbnMuY29tDQoNCg0KDQoNCg0KDQo=

