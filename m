Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D450CD46BEB
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 18:02:13 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1068.1769623323148400136
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 10:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FQYwPmPA;
 spf=pass (domain: siemens.com, ip: 52.101.69.43, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqEBQHUViqrnEOxM7vK6NwKXZfMr+juPTW+2fS9+6juXcmB48deh09je5vwyhaMZCq5+A9YayH+FSr6nDVbdIXlhyfTDFrVv4R0Xi/khBFyXJeK66mCHRJGI0gKCRFdNs7ABuqf0oNYhKJkZl4cT63uxnZ6iGNv7M/bFbNzsQz+d4BpsI65z98/qJCjGK7iOGRkWsYyT/mZeO9KuO6iLbbOxxBqn/w0w7I/lvPyuzvlGubb4rnD9sm97jcc8WsRfxDNfctUUDxVic3CNbj4Gf/A+AUzkGFa/jBcqg4RZUWGlp7rFIiKilrl986HEbIqlcSgS45q9RffwTUerQyUNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdhuQ/hfjfRDkcStc5b/oi7/xUfpl/Xcd6PJBTH3SAQ=;
 b=L+SoqEmRhiS3sujCmjHNw8uR+fGFgP/7WzL9TJTaJhQng6h7Gh7sjH3WjiovTrWpxDtto3R2EksKKjvjcQNn6guXfV9Rokjplci5AxyHKfzZRsg/0ENqGtzpyjT0QSTGvbxUrPeeANW7zLyIcrJXYpv63w4jdhNlY4KzgzGfByKnlLamg9zwuvhQcb+PbP2TC3Pb0ja+1qZmPimULW0gKLzUnM+/mLIQjlj9T99EBQFSe+dFC7mAp55q5tJEBjHxEM5KPxdwimvyfHHd16GpSvEbIHdnWicoJE4hPNkTvJBlBY9L8VEkkcZH4hGWPcRZgR7qxYFzcJTghCvpLM9ltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdhuQ/hfjfRDkcStc5b/oi7/xUfpl/Xcd6PJBTH3SAQ=;
 b=FQYwPmPAIA+sDkilAOdBuYP7KMd3gON43FnvhLEq4jTOBjpEp/j2QXcJMo244mBkxNnxQOqM/RVz6ASs4kZ7kT7Y7p1g8BmWDyvhjeTifwi2XT+ASVIvoJo0yM6lW4vPH7wt9CycyOmXssJwc5Y//8B0TmGfGSeNPvELZ5pZ86BDFuoLDNt5TfEERF+OENkFs12RZS4fAJRLLlOhCz0TujihKbGrEZnRpIErB37uXVBJRDhVxYZnXhiprVk02yP3vJ95sZrKw3gtzmGACikHdduxBUhoLnsPosEUKhy1wH1hDemw/8kNNVhPBDEkuHIwTfrdfydV+fZo+gyEw2eFDQ==
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15)
 by PR3PR10MB3804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 18:01:59 +0000
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828]) by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 18:01:59 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
Thread-Topic: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
Thread-Index: AQHciWA0+no2hYoNOEuQkOtrpvl0h7VnfAQAgAA6b4CAADcvgA==
Date: Wed, 28 Jan 2026 18:01:59 +0000
Message-ID: <d0d12eedcd058d076a2b4ee16240d3f3f1f72329.camel@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
	 <32bacc829a084a0ea04f52ccc568e3f2adb27acc.camel@siemens.com>
	 <442bbdc5-5d46-4ce6-85be-dabe01ce52e4@siemens.com>
In-Reply-To: <442bbdc5-5d46-4ce6-85be-dabe01ce52e4@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7349:EE_|PR3PR10MB3804:EE_
x-ms-office365-filtering-correlation-id: 6ee229b7-05e1-4c21-63d7-08de5e975509
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d2luZ0x1SzNNN1BTSzlsNDRkRXlnTEVmdkU2QmlBTmVIb1d4dEN5M0hQaWph?=
 =?utf-8?B?NVEzNVFYZzZVUjhmaFcvemRERzEyVUZtcUZaelFmZFgrV21sMmdVRTJwVU14?=
 =?utf-8?B?VnY0NUlVNDhsMjJYeFI0bXZPUUdKN2F1WnNTbGUxdXkyU0daZzdTZVZJbWF1?=
 =?utf-8?B?ZWlaTUx3OVphZ082RS9TdGthWmtVRE9HazFxOUJ5MlpaRmtyVnFTL29oNEc5?=
 =?utf-8?B?ZVZSYWI3UDFrUXhlUG80Qnk2NitXRmlBak5VU0c0UldhVHhOcS8zSWdHZTBy?=
 =?utf-8?B?cmF4eStXRUJXbDZLY0xqZVZWNUVyVWJjc1d5RFBGUkZ6cFBrbVVmd0JHNXIz?=
 =?utf-8?B?N1d4bXBFcnRGcEZXZnMydzR3NTc4SVR6aVNDMEZLcW9LblFqRFRaSjUyMS8v?=
 =?utf-8?B?TkUvbjE0eFo1UURBZVN2dGpiR3dVV1BlMlByZ0hicURKbmc2a2lTck56aUlt?=
 =?utf-8?B?c1VLQll1ZXh5alZ0MUVFRUh3emszQW9Zc0pZWnRiaDg2RzZiZFB2VGFrdEFu?=
 =?utf-8?B?cWNJdytGc0hDeGJHZFdENFhKNmlSakFqeDllR0gvcEUyUXFTODZtOVhGOWtV?=
 =?utf-8?B?VjBTVzJxd0JnVGo5OUFQcDhFVlBaYTlPbWc2cGozRG5uWDRjaGNmQmVYOTgz?=
 =?utf-8?B?bkthMCtoS0F6dHVBU2NCc0tzMnNrRE5Ba2dTaVFQSDVjVkt4eFFDSTdLdWZv?=
 =?utf-8?B?S2tCOWlCZTVkQVpYcXhycXBNYW53ZURaNGNrMlArTFh4WlYvNThPTFZyVmx3?=
 =?utf-8?B?TTFvVERudkhzUVNSVWU2UnFxNU1WZktzYVVMQ0FNdVBJdGFTL0VSTnpDRHRJ?=
 =?utf-8?B?b1R4bWxINmQ4aDJGV1kwT1U5TWtSb0hZSUNkSEY4dDhyeVpsVTU2NG82azRZ?=
 =?utf-8?B?RWRGamdURUhqSGRqT1FFVURMV0E1dGg5WWpKRWhDRmJVVXFmeSsvZS8zSEti?=
 =?utf-8?B?cjJtRzUyTjZ4NEJqelVsR0w4SDlzbVpDWUw4TGNST2YvYUcxSFRoRFZ4ek9B?=
 =?utf-8?B?Tktlb0YrZmExWXBKYkF6VEVmUVg5Rk55eUZsMXNMWDZIeEIzS3hjZ0JzUGJp?=
 =?utf-8?B?OTNQWEVDZ3JHSk5KT3lPSXNYaVFpT1lzQXZmRmdiSW5lSHdVakE3cWlQNUhr?=
 =?utf-8?B?K2RQV0JqWTZxbDZIOXRycW9NRVZQcldWUDNwZzRScXpnS1pDSThyOGFuRFMw?=
 =?utf-8?B?Wms0ZlR3U0dtbDBjWVJYTkJaY0JPOXkzelpGQ01zZzU3ZEo0Mll4TFhFdjRn?=
 =?utf-8?B?MmR1eEFYaFdnL1FEWE9vcHRVMUl0ZERNSkJwTnVLU2pOYnl4bTZHanB6eU83?=
 =?utf-8?B?VnJvdkZUV0hCM21oRWNZemxMM05BWGR4T1ZWNkVNNjg2Q09Na2czLy8zQ251?=
 =?utf-8?B?OGhGK2crN0RISC9maytVVWp1Z3NNcHQ0WTdkSTcxbExYTWkyOEsrQmlvS0NB?=
 =?utf-8?B?VXl6TVd4TWw1Q0pkVFl6V3U1S1RhS0ZIZjRqMmw3WDJVN1c0RmNNeTZtS3lS?=
 =?utf-8?B?VE1FYXZKOWg0cFF6TWU2YlMrMDRNSDdCZHJibU1QeEtLZW1kdk8rNmVaUUJ3?=
 =?utf-8?B?Z0dIaTJ2a1hlU1F5em5nQXFPMFdZUDZPTzRhWFlKM2pPRFBBT3puVUd0K1hs?=
 =?utf-8?B?aWFYVGt4MXFzUUFLbTNtZFYrVm9YWG5qZytVN2dzdkxqQ0dtSlNVbDMyMnpY?=
 =?utf-8?B?RUxrVnM0Y2FaSGN3QlVNcWY0OVZCZitjYzBneWJVVDdoK3RKMStVQW1sSkNj?=
 =?utf-8?B?UmVKVUpXQzM3aGtCMU5LQ0JuVDZLTzFCNFA0V1pGUE9ETU9KNVVhcGJJWkw1?=
 =?utf-8?B?ajlZeGFVSE1zeUkyR0d0TE5MdU14ZXRQQ3VtWjlSdTY1eTBOZ2xPMTYrMGZW?=
 =?utf-8?B?UXpFbU9LN3dEbE1PMng4VVhPMC85bFdHK2ZUV0VULyt4a3g5NXNKa0JTazlq?=
 =?utf-8?B?MmhwNWJxUU1RemsrRmNZei9QQllURDEzc0xwYmZzRUlQTWJ4TEVNb0cyOVFr?=
 =?utf-8?B?NHJoUk5tekhRWTk2dW14bVRsUzFRaWxxdkx1NVdMSmdBWFQvTXRIam9KSEF1?=
 =?utf-8?B?cTUvRjlLc3Z6NXIyVTdnWk52cTY2eWRsenBsbE4yOGlWVXJsQU96b09HdDdR?=
 =?utf-8?Q?CuyoZxtrPd33nu1lpBPBZCuuG?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QjNSUUUzR2k1OHRRNEo2WllqZUZITHpnV3R6YzZRUVpSY0hDekhiaURCMDgr?=
 =?utf-8?B?Qm9ZWFhqMmpQUG1tcFBwRVFpR2swWFphUzVpdloyN1daTWx3MGFKYlg2QS8x?=
 =?utf-8?B?T3ZtRGRiWDdTbzM1S3B6ckdrdGNLYldBUnlnTU9NRk5uVmpRdkFLUitsOXlD?=
 =?utf-8?B?cXpOWElpbWhNVlJMWUFMRm45NXEzbHZ5Y2ZIajN2b203VU11b1NYSHV4Mk5S?=
 =?utf-8?B?UUF5dXV2bGZRb3F1MU45TE04SEZRaitETERpbmhJUFlyWlFpVWpab242MVo5?=
 =?utf-8?B?dkVScGRFeDRvOERuczhGa01CRXpzN0RIRU1rSEQzRFA4SldBbHNtSFhtWXZT?=
 =?utf-8?B?aTcyT21wVU5CdEFHWGxjMkd1TFB3aWM0aHZkRjZQak50MlpOb3MvczA5TWo1?=
 =?utf-8?B?dmZqa0RGRWlneFEvdzJublNUc0tZdm9XSlpKcldoSExjMjU0clliaUJEeUFF?=
 =?utf-8?B?VlcvRkYwV1JWT0FyZDBYTEd6U0ZLdmh2OCtMU3JMckFHVDBNeE9kMWJISVBE?=
 =?utf-8?B?NkFYOFRQUUEvd3JoWEt4dW5BbGRHWjEvT29pbmlWRFlWNm9saTVocGJ6a3FY?=
 =?utf-8?B?VGY0ZFNNUFdCaXBkSnpIYUd0cFR3UkRlR0lYTFVrVGJtY0pGL2h1R29WeFhL?=
 =?utf-8?B?d0Eza3F4VDBPQXozaS9qZC84Z0l2a0d6L3NiczFSNTJTR1FscmVPcFdRdDB0?=
 =?utf-8?B?bStSQmdING5Xd0kxbGExTER2NXJjckFsaGxiVGMvVHAwaWhWR3ZlNWl5Vmt5?=
 =?utf-8?B?TFp1c0RJTkZ6WWc1NmRyREorRjFEQklhMG8wZGJGRkhKbC9LL1EwSUZBRHA3?=
 =?utf-8?B?UlRQdVVmZStGUWtuQVhCQ1poa0RON0xPWXRaUml5WC9EakNHc2hoUHQxK2do?=
 =?utf-8?B?SU9DbFF0a3ZUQkhka2FlQW9QSXBTTkZiVjdpMFVsdXFpbHlDaXBGbWN6QllK?=
 =?utf-8?B?WmxDams4dS8xa3lLQ3p6K0JkV2JCNWRZZnQ4MEFCMGwyK2R1UHc2dDhMcjB6?=
 =?utf-8?B?T3lEdE5qbGJNM3BqWEtjdHIxUmdIZWgwcjlwTW54TElUeDFORHBaT0hPNUc4?=
 =?utf-8?B?cG9WaGFpSTdheGhWWjF5SzJ6ZkhHc0JuSDBDWkFiNFUxUnZ2U1JTSExWUHpa?=
 =?utf-8?B?aEYvOUw4V25QalUvYlQ0ei9DTkdEOHFIWmluS1NOaExTNnNheUQvakRMQnFU?=
 =?utf-8?B?dmFNR0krUXhvcC8wWkVFNll0YzZpRm5STWNmWUxwbCtEKzVuRTlYOEthWXR0?=
 =?utf-8?B?Vkh5YXAwc2QvS0tEaGNoRC9SSlhETmJzRDBxK2ZCaTFLWWdDVFJod1JScHpr?=
 =?utf-8?B?QmI1VmtJMFEvaWdwczVpVm9ZUTF1UWthMVlqeGR4OHZHRVVjUW5WOWUrQjB2?=
 =?utf-8?B?eGlTZG9YKzFHNFFKT2tPK0RjYTA0N2FhWjcrZ3k1UzNJTXFOQnQ2Smg1endh?=
 =?utf-8?B?czJDVDJvMW1RdnlkQkR6ZmxNSFcvUzNteUUycEFIcnJHcDVHUnNWOXpOc3Za?=
 =?utf-8?B?OW5jc2pSUU9CV1JrNkRmOTVtc0Z4dGpicmJOSmk5eWRISldlcnZ5Y3dxdFBD?=
 =?utf-8?B?NVVXdHdjMXMyVERpaDMxQlcwdUlVWnErWWpMV0tuVUNMckQvUjZnWG1oSFZR?=
 =?utf-8?B?Q1NtSGY3WUZYcGVUdFlzRG5rZ2tqTndiY1lMTW52WERhY1kyQXc1ZWdJUDZ6?=
 =?utf-8?B?dENrSTJQVFZGZXhhWWtVWmlwekc2N1lZMkZtQlZmQW5KbnoxamNFMEp0dWQx?=
 =?utf-8?B?VG44TU5KWHl5Z1JtaGRCM2FXWW81UUtzVncwZHJpMTMwSVYwWGptVHpJR3cw?=
 =?utf-8?B?VWVsZktobUVFdlpSNFczemgzNmkvNWtiMXJsc0FuUFFJTVptOUJLOEF1OWpX?=
 =?utf-8?B?bVpUZFdZY2cyMDdxcTl4bW9PK091N0c3SjFaaWtYWndzTTlWaWN2N0hZLzIw?=
 =?utf-8?B?K2ZwU2tmM2QwZTFtQmkvRVBmeTNPUll4WG9jUm9QQmRPU1FnblRoNWVyTWhq?=
 =?utf-8?B?TW16aUJoYTRTK3IzSmc4ZE1RdHBIOFN2OHVGWXhMK1hmdDBUUFBGT0VjZDBO?=
 =?utf-8?B?bVloNlpuc3RRbzlUQlViVmV2bzBKN1lwWGdSS01lUHY5WFBKc0hxdGxnMEhY?=
 =?utf-8?B?b1pTZ1dReVM3Z3VoRnhFc2VYQkxYY2l4NExiWmhjZGR3VUVtaHg4eHB2cHJo?=
 =?utf-8?B?TWRKTUR6OXhBeFhMWEJGeWg1OVVkcHBuak5TZjdrV3FkRWtERTViRUtmbzlG?=
 =?utf-8?B?UFhvTFgzNlpmWWpFNXJ0MDhydS9idzcrbEVTMTNBQnpUeUVMMGFUWjJYdDJv?=
 =?utf-8?B?N3hLRHdIUk1ibzAxei9GbjUxSnhLbG9ub0hUS2FUZWxaNTFsb3dwUGFvMDQr?=
 =?utf-8?Q?GRMCy+aS5u8UwBChLbL093ai+kDfQ7jQX/wya?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4C07C78EB77EB4994103F90837B2F3F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee229b7-05e1-4c21-63d7-08de5e975509
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 18:01:59.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zj3OCecKs/PxrTrSVhD08I+zfQ2/9QvOdEmY4L2MY79P/6rTiPROqnbc7N1Tttrq8uoP9cGWfI09vwE6TECkxdOjx4J0WoR2d1QG8yDwtOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3804
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 18:02:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21778

T24gV2VkLCAyMDI2LTAxLTI4IGF0IDE1OjQ0ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyOC4wMS4yNiAxMjoxNSwgSGVpbmlzY2gsIEFsZXhhbmRlciB3cm90ZToNCj4gPiBBbnkgY29t
bWVudHMgb24gdGhhdD8NCj4gPiANCj4gDQo+IFF1aXJpbj8NCj4gDQo+IEFuZCB3aHkgZG8gd2Ug
bmVlZCBuZWVkIHRvIGZsaXAgU1dVX1NJR05FRCBpbiBib3RoIGthcyBjb25maWdzIGFuZA0KPiB0
aGUNCj4gcmVjaXBlcz8gSXNuJ3QgdGhlIGxhdHRlciBzdWZmaWNpZW50Pw0KDQpUcnVlLg0KDQo+
IA0KPiBKYW4NCj4gDQo+ID4gT24gTW9uLCAyMDI2LTAxLTE5IGF0IDE3OjI0ICswMTAwLCBhbGV4
YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20NCj4gPiB3cm90ZToNCj4gPiA+IEZyb206IEFsZXhh
bmRlciBIZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gDQo+
ID4gPiBUaGUgc2VsZiBidWlsdCB2ZXJzaW9ucyBvZiBzd3VwZGF0ZSAodXNlZCBieSBkZWZhdWx0
IGluIGRpc3Ryb3MgPA0KPiA+ID4gdHJpeGllKQ0KPiA+ID4gZG8gbm90IGVuZm9yY2Ugc2lnbmF0
dXJlIHZlcmlmaWNhdGlvbi4NCj4gPiA+IA0KPiA+ID4gYGBgDQo+ID4gPiAkIHN1ZG8gc3d1cGRh
dGUgLW4gLXYgLWkgZGVtby5zd3UNCj4gPiA+IFtERUJVR10gOiBTV1VQREFURSBydW5uaW5nIDrC
oCBbcmVhZF9zZXR0aW5nc19maWxlXSA6IFJlYWRpbmcNCj4gPiA+IGNvbmZpZw0KPiA+ID4gZmls
ZSAvZXRjL3N3dXBkYXRlLmNmZw0KPiA+ID4gW0RFQlVHXSA6IFNXVVBEQVRFIHJ1bm5pbmcgOsKg
IFtyZWFkX21vZHVsZV9zZXR0aW5nc10gOiBSZWFkaW5nDQo+ID4gPiBjb25maWcNCj4gPiA+IHNl
dHRpbmdzIGZvciBtb2R1bGUgZ2xvYmFscw0KPiA+ID4gW1RSQUNFXSA6IFNXVVBEQVRFIHJ1bm5p
bmcgOsKgIFtzd3VwZGF0ZV9kZ3N0X2luaXRdIDogcHVibGljIGtleSAvDQo+ID4gPiBjZXJ0IC91
c3Ivc2hhcmUvc3d1cGRhdGUtc2lnbmluZy9zd3VwZGF0ZS1zaWduLmNydCBpZ25vcmVkLCB5b3UN
Cj4gPiA+IG5lZWQNCj4gPiA+IHRvIHNldCBTSUdBTEcNCj4gPiA+IGBgYA0KPiA+ID4gDQo+ID4g
PiBUaGlzIHBhdGNoIHNlcmllcyBlbmFibGVzIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gYnkgZGVm
YXVsdCBmb3INCj4gPiA+IHN3dXBkYXRlLg0KPiA+ID4gVGhlIHNlcmllcyBpcyBzcGxpdCBpbnRv
IHR3byBwYXRjaGVzOg0KPiA+ID4gMSkgQnVpbGQgc3d1cGRhdGUgd2l0aCBzaWduYXR1cmUgY2hl
Y2sgZW5hYmxlZC4NCj4gPiA+IMKgwqAgVGhpcyBzaW1wbHkgZml4ZXMgdGhlIHByb3ZpZGVkIGRl
bW8gYnVpbGQgY29uZmlndXJhdGlvbiBpbiB0aGUNCj4gPiA+IGthcw0KPiA+ID4gZmlsZQ0KPiA+
ID4gwqDCoCAoKyAuL2thcy1jb250YWluZXIgbWVudSkuDQo+ID4gPiANCj4gPiA+IDIpIEVuZm9y
Y2Ugc2lnbmluZyBhbmQgdmVyaWZpY2F0aW9uIGZvciBzd3VwZGF0ZSBieSBkZWZhdWx0Lg0KPiA+
ID4gwqDCoMKgIFRoaXMgcGF0Y2ggbW9kaWZpZXMgdGhlIHN3dXBkYXRlIGNvbmZpZ3VyYXRpb24g
ZmlsZXMgdG8NCj4gPiA+IGVuZm9yY2UNCj4gPiA+IHNpZ25hdHVyZQ0KPiA+ID4gwqDCoMKgIHZl
cmlmaWNhdGlvbiBieSBkZWZhdWx0LCB3aGljaCBtYXkgYnJlYWsgZG93bnN0cmVhbXMgcmVseWlu
Zw0KPiA+ID4gb24NCj4gPiA+IHVuc2lnbmVkDQo+ID4gPiDCoMKgwqAgc3d1cGRhdGUgaW1hZ2Vz
LiBIb3dldmVyLCB0aGUgZGl2ZXJnZWQgZGVmYXVsdCBjb25maWcgZm9yDQo+ID4gPiBzaWduaW5n
DQo+ID4gPiBhbmQNCj4gPiA+IMKgwqDCoCB2ZXJpZmljYXRpb24gb2Ygc3d1IGZpbGVzIGlzIHBy
b2JhYmx5IG5vdCBkZXNpcmVkIGFueXdheXMuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQWxleGFu
ZGVyIEhlaW5pc2NoICgyKToNCj4gPiA+IMKgIHN3dXBkYXRlOiBCdWlsZCBzd3VwZGF0ZSB3aXRo
IHNpZ25hdHVyZSBjaGVjayBlbmFibGVkLg0KPiA+ID4gwqAgc3d1cGRhdGU6IEVuZm9yY2Ugc2ln
bmluZyBhbmQgdmVyaWZpY2F0aW9uIGZvciBzd3VwZGF0ZSBieQ0KPiA+ID4gZGVmYXVsdC4NCj4g
PiA+IA0KPiA+ID4gwqBjbGFzc2VzLXJlY2lwZS9zd3VwZGF0ZS5iYmNsYXNzwqDCoMKgIHwgMiAr
LQ0KPiA+ID4gwqBrYXMvb3B0L3N3dXBkYXRlLnltbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxICsNCj4gPiA+IMKgcmVjaXBlcy1jb3JlL2ltYWdlcy9zd3VwZGF0ZS5pbmPCoMKgIHwg
MiArLQ0KPiA+ID4gwqByZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGUuaW5jIHwgMSArDQo+
ID4gPiDCoDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+ID4gDQo+ID4gPiAtLQ0KPiA+ID4gMi40Ny4zDQo+ID4gDQoNCi0tIA0KQWxleGFuZGVyIEhl
aW5pc2NoDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

