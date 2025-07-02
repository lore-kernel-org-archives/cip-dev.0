Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B18AC7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 09:58:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.19870.1751450319457474245
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 02:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5629waaO062815; Wed, 2 Jul 2025 18:58:37 +0900
X-Iguazu-Qid: 2rWhEqwpmhN9NdunZq
X-Iguazu-QSIG: v=2; s=0; t=1751450316; q=2rWhEqwpmhN9NdunZq; m=agP3wqrFiT3BzUlsPme+NH2EWnUjXtTFyKMNpSg0c2E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5629wZXR2906227
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 18:58:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2mb8MMCw6aBtlyZ/n09U+jA2UBAkqvXLKdLSxgD8c+zTIMA0Bwn0V4HmnEnIjABvJxrkxROJ8CzPF1KgHNxqsrT3g8h6tEFkIp4n86GLlGiyIwC6PZ2xNcMkAz8JI9oITherQxnL7EYrusyOsPlZjq8kny+ruvt6/6pWkrzKcl+d8IR4L0Z6bjAhQM6JKvLcluLSyMubFfoMe2EEr00W39K06kBRvVhhmcJ01ss56sUqRJIpMqhTctib+nwW7llqca8RHTGCwpxGZPZ69OoiW7BwY/VNxPNUL92doaDASDMBdaN7JNFPeuUq8UY/aA5Ai95OrRmgFFLLBLvtA5GTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq3pRXnGh3HTJfAF7KUnYBhIf4QGM16c+8RV/DuQRtY=;
 b=gF5GHJjfzgWlR2eCE4QXrAUqCArTo6xk2cXSS8cFfrFYIPw0cSCVHn94fOZbhFMgGYX2ObNdzEkf0UYf7x5EIybhC1de8uKQsdVbxWxQ6jo3Q0wQ9KY18EEx/sscIABeRgRtgbnQsmxE+FlgwRLGvllSxTGmXKJBU0Jkp8oeikfmqo2NmyTTbWFKVsSigNJbFf05dPUyMscyek4V2dGKoMiqNmVrOXp0QDWmIt//J5UXDfr+PdvGxgTukLKVKo5tPA/b7pVUO29ehb9KpQTHZSIeBvc9lOO2LFbDukxIa6i4Fl0+m5YCDLSu1vsFeEZbWZJstshJRtmEopejHT+r8A==
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
Thread-Index: AdvrHhlzn/A/DOQaQCWzDQhadgxFugAAWvSAAAJFldAAAq2dgAAAqsrw
Date: Wed, 2 Jul 2025 09:58:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
In-Reply-To: <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY7PR01MB15766:EE_
x-ms-office365-filtering-correlation-id: 36a2edf0-642c-4c2a-1b03-08ddb94f0179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V3gzdUQ0S1U3bnBoRXJlaC9CVnFjMFpyelRhQk5LaEV2VXUzMWhCUFJORWdu?=
 =?utf-8?B?cWNYSnVOZjE0OThpOXpiZ3JMMlpXOFpBbzROMlZWa0FZMUkxdDc0bllRWXNs?=
 =?utf-8?B?T0lJMTBkaDRjUHZ2MkhEU21reGM5Um5ka0xwS095dkIva3V0NDgyWlJ6cTls?=
 =?utf-8?B?NlNINmo2QjhoQnhqQlNjNzJmRXg2NUc2eU93d1BFVVBjZC8rL1FFWXhIVWM3?=
 =?utf-8?B?N3ZiOW4ydnBYU0hNeUVkS0k4eTIrVFYzemk5MjRIQXBGaVp3RVBneHFSeGxK?=
 =?utf-8?B?L0ZGSHF5SmFnRG9Gd21KZGYzTGlBUzV5RWY2bnNybFE4dDhuMXVyQkNHOW5o?=
 =?utf-8?B?bnBqZG5tWVp1UXNCb2tpNWU1ankwVHBoblNCUlh6dUFsNFcvKzZTN3pDQnpz?=
 =?utf-8?B?VHloVUVZUk4xazNMSjFydnVoZjIzQlNpdUtKYTc1eGhqbE5KQU9oT3JOQjg5?=
 =?utf-8?B?QUFEODRma1plL25iMy9FWGMyWitWa2lKSnFUeXo3QmQwV2FEL1lTNHBVYkRj?=
 =?utf-8?B?Ullhd2FnbU5idGQyOGY1eVVIN0pRZkE5REI3QWc2emtmTFhGR3JNbWhRcXdt?=
 =?utf-8?B?eUhla09NWk9naGQ5eWVCaTBURkNNNE5mRjJQWGdTZE9KQnNsSUtsRWZicHV4?=
 =?utf-8?B?d0tLQ2o0cFdaRTZVdHNwa3lvTy9LbnRoNDU0azlRVEpTaGlsbU9PaE1jaVNt?=
 =?utf-8?B?RVVqcm5ITk9GRlJUVXJ3OEVyd2lyRGY5MUJUcU04RStiV2dKU0ZzWjk0cjRo?=
 =?utf-8?B?alJMVVFEOGhMRzdmN2xOZEc2MmtTUmVZWU5Xd2dKNnQvVXhPMFZ3NXNYV1J4?=
 =?utf-8?B?b2cyalJwV3B6Qm1ZUW5xa01HZFFFc2VZZFJuNVdrTUZNelhVMHlzWFRFT2pS?=
 =?utf-8?B?NUFDejRRUVZBT09vajB3cGxxZVk5WkFVelAzVlBZcDMzOG9tWEtZb1gvdmhV?=
 =?utf-8?B?S2lEOC9uelpMYWZyWEZ6QzM3QVVabDJiV0FTL3UrNGVKR05DWjhxQ1QydVdH?=
 =?utf-8?B?c3gyQ2VCMjVwakRLUTk3U0VZOHFNdWRGcDc0VVRTY21lYVBVR1ZpeTA3UUtH?=
 =?utf-8?B?R0ZKZ2cxc3MxT21BYmJiYXFrVEw5ZVZNdkFxZEpMUEhvb0w5K09ZUU5XZ0w0?=
 =?utf-8?B?d1ZMMlpRNFo0UzFsTGNCUFZ4Vys4bktzSGVkcWZlc1Q3T01BNTEzQk8wbVZw?=
 =?utf-8?B?N0l0TVdXUXFCdzhyQ2g4VUIrWTNWbHpBSkhRRVpGMU1peEFDVmVxVFZNY0hj?=
 =?utf-8?B?bkJlZnpsVUkzeEc0am44L1V2bTR5K1g0aUJjdG5NUmNaY2tRQ3dJaDJ5SWxw?=
 =?utf-8?B?WnQ0VHBGMFRnUHZtSGFsVXkxL1YrVS9iZThFWWV4VUIrbXptUjRXSDZudzBh?=
 =?utf-8?B?SmV2eDFYUko0TnJrN0s4VWhNc2N1RWUyK0kraXB6U08wcnpVbXN6eEFZMDV3?=
 =?utf-8?B?Yko5WVd5M1RFZWdBaHNRZEZmODFsaG9xeEx3QVN0QlBsMnM0aFhuOERFZlpL?=
 =?utf-8?B?MWpEWTdNS3VHUkN5bzhkOFh2cFVndHV3M0dlTFloa3Rqb1Q4ZFV6N1BLVWZv?=
 =?utf-8?B?UDduSVUyV3JJa3p3a1N3bHRhWkNLZy9FaFNQU1hwUkpIUHlSN1FETk8vRUZR?=
 =?utf-8?B?WTk3SnF0ZlNkc25CeUNaL01KMnZwMThJb0ZKUXZkcHVobG1KZEpyUmZ5VUZ3?=
 =?utf-8?B?KytiQkl2enp1ZENROFl2VlFTb2pPdVYzTTN6K3NXeWtTTDFNdzFRUHA1RGxo?=
 =?utf-8?B?VUMrVjVndTkwZ0cvelc5SytQZEJFTHVVenl5TS9Ga1FiQksya09BUWczd3Yx?=
 =?utf-8?B?NkpVYVQ1MjBGSEV3Z2JmNncwbjUxYk5NbnVTUk1ldkNIc3FaUUVzZWJENWhk?=
 =?utf-8?B?TVloSFBKSjNtQ0xaWDI0enNnalRtL2UwMjFuZUVYbDh1ek9XbUJBR2ptS1BQ?=
 =?utf-8?B?UWFiZC9DdEF1MWlqdkJJdnQ3eFdlTkF3bTdDMGsrRUNNYmxSRXhPTFhuUEwz?=
 =?utf-8?Q?kztbkyHTkP1kyVX5BYKLQOz87EumLM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?enAvR21xTnhFR3hocmx0TVpVdERmOG9JU3o4YmwzMEJPNTNMaG1SMXBUS2R1?=
 =?utf-8?B?Zy9UWmdaamZxNWFBRWsyV1B1REVPR1crZ01nUVdsa2Vla3dpck01Q0NYMTRK?=
 =?utf-8?B?U2QwRzJTamZGY2V0dnNaRE9mUnl4MEpKMkl0c3doUzByak5lYWQ5aWp4aEJi?=
 =?utf-8?B?Ny9rS0tURmZaQldyeHdWeVYvZWdJUzZnait0dlNmNEJEYnJvdno5c0RJTk1y?=
 =?utf-8?B?VUsxdG1yby9YTm1QaVFBY0l5Nm1XMk5pbzdVSy9VTjViSXM0WFJLOUZFNW1S?=
 =?utf-8?B?eGprVWVGMysvTnZQSlhzdXlHUUJVL29TS1FtRjAzaHo2T0tXSlpoOUdwckZG?=
 =?utf-8?B?c2RZUnZUTS9KRjJ3bHZEbjlaWlJUOFRUYkF0Syt0Y2pIY3lCUlIrbVdPZ2Ex?=
 =?utf-8?B?eGROQ05hMWYzSS9JMmI5eTROZ1dyKy9LT01MWGNKZ3Z5eFJJM0wvY2IrWE1j?=
 =?utf-8?B?aExoY2hLUzdkamkzcUhkSDFaLzBnQTRYMXFSME4rZ2lraHBLd3pyM1N1ZWF1?=
 =?utf-8?B?YVZlaU1wY2ZURCtKVzdYQlJVelg4UFk5eGVjYkdqZHJEMSs2TkJpb3B6cGtW?=
 =?utf-8?B?MXp1NVJySXQ4eTJCY2c4TytnZllmSHdoWERKanRCU2NBV2ZxVE40TlhCVnlE?=
 =?utf-8?B?cm94WjFLZjAvYk4xTmh5NFN0dVdCQm1tV2p3Qm5TbWgzRkx3UTE1MEg0NUxW?=
 =?utf-8?B?N3VTTTFpY3B1TzJlZ2VPZVEwZ3RSWVNxUFpja0hGMFhJRXV4ODdVYkg0eVly?=
 =?utf-8?B?bU56Zm12L0hQSzhBbWNXUnpvemR2QzE4RUYzdG5reGJyZzRweElnYk9CN3BO?=
 =?utf-8?B?ZmZoTkdwWVNGQklEVHFLMWgzTHpTV0kvTGMwR2ZSVTBkM2RZMkdmMkZ2aXg3?=
 =?utf-8?B?Z2VHS0R1RU1KY29icC9yYURsRDhmOWhHbUVLRWcydEo0SXFxbkR1RFZyQ2tN?=
 =?utf-8?B?SC9CUDdUaHdKME9EZi9jNnVzVGhVQlo5dWhQZTB2ZVFCRTVDYUx0U0RaWGFi?=
 =?utf-8?B?bjRUS3JwNXBBOWpNUUtoeThVVENmSENiQVl0UGVKNSt1L29SbXdKTGgrNGVP?=
 =?utf-8?B?dHR4ZUhLazB0NDN0NVQrNDRBWHQxU0dSY1psK2ZVV0VOWlBxL3A0Mkh3eFhV?=
 =?utf-8?B?bkFWOXFBTnpMdXloemR6MkRQSXRWZCtjTm5pSFlDWnh5dGRoMDVRSEhsRTJN?=
 =?utf-8?B?TWhuSXN1UjZOVWFpVkVMTmk5UnIwci90cVFLWlJzY2JSN2tNV3NvYTB1SGdP?=
 =?utf-8?B?cFdtSXJITEdvOWVvSXBqN1N3RnBaQzQ1aE5Rd3UwYXRZcW5HSXRJUzJCb2lB?=
 =?utf-8?B?NUd0Um1jSmtkVm1HeURkc05xbUhuVWdzNzdMWW1oQy9kZ2Rld1FEQ1Q0UUhL?=
 =?utf-8?B?VGYrUnEzQkZZNU53Skloc28xTWVEdmc5K3duSkR6UWN1RGhIbU5UdUtPblRY?=
 =?utf-8?B?V3U0ZGNBSkFkcjZVRUlPNUlTMnhqMmVqaUlHSEpKUmhsU29JOTFzTVVSd2VN?=
 =?utf-8?B?YzdhZ1VqUmpHQlo3K1dEa2xQREZ5L2J6Y01FSXFMUzB6aHVUSlZ2bktzcDZq?=
 =?utf-8?B?eGowaWlOODM3TkJBT0U0cjhJdVZhbkg2WHlxbDhHa0RxTzc1aU83ZTU0amR0?=
 =?utf-8?B?WTRFT0h5VDlnT0EvSW1ySjdBZWZrVXdYK2toQ2d2TklFOVpLVm5nZ20wT3Ra?=
 =?utf-8?B?N0RkS24wWnBrN3NTekYzb3puczRTYVk4WTlZNFFFZ0JsbkxLcERwVU5kMGd6?=
 =?utf-8?B?YnhjNldxTGR4LzJqYVp4bXVnQWJjZUp3QzR4ZVB3K1EzSGY0L0EvWjA5eDJP?=
 =?utf-8?B?dnRzNlNjaDNCeVYvOFQ3YUNxSkw2d1l0RGc3bkQ3SlRCTm1XSUIrb0dTTGpr?=
 =?utf-8?B?UUkrN2xTby9YazNIQXpHLzA2WjlxQnljVDRwK3FiNmp5eGI4bS9lcm8wU203?=
 =?utf-8?B?VEZ4d0RMT0lBL1JsYnR6NFFxY1ltQTQ1Q3QxOU9lOU84VTZDajAya2ZVNFlL?=
 =?utf-8?B?TnBGbFJkT2FNdk94aDBkVFpJd0RFMENPNzNvK0p6QlErUmVKeW5vTE9aa1Fk?=
 =?utf-8?B?Qk5POW4rSU8xQlI0N3lsU2d1dnpFTE1CSFNkNit5MEJHUVVqeWFIZE5adGZt?=
 =?utf-8?B?NUtCa1lQMEorSTRLSnY5ZVV6RnF5d1M5aVVoQUp6dlBCdVNWZTYwUHRSUlRH?=
 =?utf-8?Q?37Zp5i7B5M/GE+7QWGsTZY8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a2edf0-642c-4c2a-1b03-08ddb94f0179
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:58:33.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pE6mrg879B5YFknvg2uQHvB7plBdQ6EhR9ogQ7O0FhP1ITh5GtjHocUZ+2mB0ewsAA6OIz2KlxlLTw/xsP3908ORT2kUUIFcF9oQeqvMwbelQGAct/c4J+HPXStO2PAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15766
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 09:58:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19283

SGkgSmFuLCANCg0KPiBOby4gSSBtZWFuLCBvbmx5IGlmIHRoZSByb290ZnMgaXMgZW1iZWRkZWQg
aW50byBhIGx1a3MgY29udGFpbmVyIGJlY2F1c2Ugd2Ugd2FudCBpdCB0byBiZSBlbmNyeXB0ZWQg
YXMgd2VsbCwgdGhpcyBraW5kIG9mIGVycm9yIGlzIGV4cGVjdGVkLiANCg0KVGhhbmtzLCB1bmRl
cnN0b29kLiANCg0KPiBEbyB3ZSBidWlsZCB0aGF0IHNlY3VyaXR5IGltYWdlIHdpdGgga2FzL29w
dC9lbmNyeXB0LWFsbC55bWw/DQo+IElmIHdlIGRvbid0IHRoZW4geW91IGxpa2VseSBkaWQgbm90
IGhpdCB0aGUgcm9vdGZzIGJ1dCB0aGUgbHVrcyBjb250YWluZXIgZm9yIC9ob21lIGFuZCAvdmFy
Lg0KDQpJbiBDSSwgd2UgdXNlIGthcy9vcHQvc2VjdXJpdHkueW1sIGZvciBzZWN1cml0eSBpbWFn
ZSBzbyBpdCBpbnRlcm5hbGx5IGluY2x1ZGVzIGthcy9vcHQvZW5jcnlwdC1kYXRhLnltbC4gDQpT
bywgaXQgbWVhbnMgaXQgaXMgaGl0IGJlY2F1c2Ugb2YgbHVrcyBjb250YWluZXIgZm9yIC9ob21l
IGFuZCAvdmFyLg0KDQpJbiB0aGF0IGNhc2UsIGlzIHRoZXJlIGFueSBvdGhlciB3YXkgd2UgY2Fu
IHNpbXVsYXRlIHRoZSBkbS12ZXJpdHkgY29ycnVwdCBzY2VuYXJpbyBieSBtYW5pcHVsYXRpbmcg
dGhlIC53aWMgZmlsZS4gDQpJZiBub3QgdGhlbiB3ZSBjYW4gYWRqdXN0IHRoZSB0ZXN0IGNhc2Ug
dG8gY29uZmlybSB0aGUgdGhpcyAoQ291bGQgbm90IGZpbmQgZGV2aWNlIG1hcHBlZCB0byAnaG9t
ZScgY2Fubm90IGJlIGVuY3J5cHRlZCkgYmVoYXZpb3VyIGl0c2VsZiBhbmQgd3JpdGUgdGhlIExB
VkEgdGVzdCBkZWZpbml0aW9uIGFjY29yZGluZ2x5LiB3aGF0IGRvIHlvdSB0aGluaz8gDQogDQpU
aGFua3MgJiBSZWdhcmRzDQpTaGl2YW5hbmQgSw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50OiAwMiBK
dWx5IDIwMjUgMTQ6NTYNClRvOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBESVRD
X0RJVC1PU1QpIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgRElU
Q19ESVQtT1NUKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtdHNpcC5jb20+OyBoYXlhc2hpIGthenVo
aXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj4peL77yj77yw77y0KSA8a2F6dWhpcm8zLmhh
eWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gTEFWQTogU3VwcG9y
dCBST09URlMgZG0tdmVyaXR5IGNvcnJ1cHRpb24gZGV0ZWN0aW9uIGNhc2UuDQoNCk9uIDAyLjA3
LjI1IDEwOjIyLCBTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+
IEhpIEphbiwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlcGx5Lg0KPiANCj4+IElz
IHRoYXQgb2Zmc2V0IHBvaW50aW5nIGludG8gdGhlIHJvb3RmcyBwYXJ0aXRpb24/IA0KPiANCj4g
WWVzLCBpdCBpcyB0aGUgc3RhcnQgYWRkcmVzcyBvZiB0aGUgUk9PVEZTLiANCj4gRXZlbiBJIGFs
c28gdHJpZWQgY29ycnVwdGluZyBST09URlMgc3RhcnQgYWRkcmVzcyArIDEwTUIsIGluIHRoaXMg
Y2FzZSBhbHNvIEkgZW5kZWQgdXAgd2l0aCBzYW1lIGVycm9yLiANCj4gDQo+PiBBcmUgd2UgYWxz
byBlbmNyeXB0aW5nIHRoZSByb290ZnM/IElmIHNvLCB0aGVuIHRoaXMgaXMgb2J2aW91c2x5IGV4
cGVjdGVkLiANCj4gDQo+IFRoZSBsYXZhIHRlc3RzIGFyZSBiZWluZyBydW4gb24gdGhlIHNlY3Vy
aXR5IGltYWdlIHNvIC9ob21lIGFuZCAvdmFyIHBhcnRpdGlvbiBlbmNyeXB0aW9uIGlzIGVuYWJs
ZWQgYW5kIHJvb3RmcyBoZXJlIGlzIHNxdWFzaGZzLiANCj4gWW91IG1lYW4gaWYgdGhlIGVuY3J5
cHRpb24gb2YgL2hvbWUgb3IgL3ZhciBpcyBlbmFibGVkIHRoZW4gdGhpcyBpcyB0aGUgZXhwZWN0
ZWQgb3V0cHV0Pw0KPiANCg0KTm8uIEkgbWVhbiwgb25seSBpZiB0aGUgcm9vdGZzIGlzIGVtYmVk
ZGVkIGludG8gYSBsdWtzIGNvbnRhaW5lciBiZWNhdXNlIHdlIHdhbnQgaXQgdG8gYmUgZW5jcnlw
dGVkIGFzIHdlbGwsIHRoaXMga2luZCBvZiBlcnJvciBpcyBleHBlY3RlZC4gRG8gd2UgYnVpbGQg
dGhhdCBzZWN1cml0eSBpbWFnZSB3aXRoIGthcy9vcHQvZW5jcnlwdC1hbGwueW1sPw0KDQpJZiB3
ZSBkb24ndCB0aGVuIHlvdSBsaWtlbHkgZGlkIG5vdCBoaXQgdGhlIHJvb3RmcyBidXQgdGhlIGx1
a3MgY29udGFpbmVyIGZvciAvaG9tZSBhbmQgL3Zhci4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFH
LCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQo=


