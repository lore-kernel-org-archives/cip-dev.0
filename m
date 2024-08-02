Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48EDC3DA4A
	for <webhook@archiver.kernel.org>; Fri,  2 Aug 2024 13:20:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.92443.1722604825461310620
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Aug 2024 06:20:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 472DKN8V195138; Fri, 2 Aug 2024 22:20:23 +0900
X-Iguazu-Qid: 2yAb5mQqVWxFGK2XCc
X-Iguazu-QSIG: v=2; s=0; t=1722604822; q=2yAb5mQqVWxFGK2XCc; m=XVOPMbJq/Q5Rlitt/t3SjRy7LHMprxe7B+9/ac6v0bA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 472DKLfx2283164
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 22:20:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfnqPKf92/ARaxJ9ltfqR2UZ389nMj3/3S9WpgtbaWTVLS3FczICI1yZyQKfOkyTEsk0MXbnroffr+IPRzrk4s1gErVXZNd32fUPJtmjWjem2xp7OFu0NEYQAaX/Dro/F1v6ZV5wCrhiUkNUiTEM5kDfQ4sZ0pgkZTgAxaePjCywetdAz1B//qYcFBhg4s5b6AwabER0xxl0G54YjPb9f6gxSoX6ep5NNEkWydTZxJrlBd6xdzehY5hTWcJl0qLXjJcz1VKC4rbv9glbTqnPTuJuMCgFjCqSOpMZiZmgdhCHrw9xuoZaRVHRHfARFFfHKxIc4T8+bQqs2qWFsqR78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlMOHt6DSqyy7mqVdtqA0hycb9Au6FDRaRsQ+bmEZLk=;
 b=BfKU8ddN0nW6iVo151EsYKbALZHvbrfTvjAoUZi2jRzPr0QEKboE+JObd8WY1vMiuceOxyymNbnf9fBTxX3hQgqyCTLEjtUcBAHgPe9pQ6XWdVQL+Xbv8d+zQvhjU7G2YWaM8iIj5ij20iCoAKrE8dpiWphIC4d+kPM7WNSQHV5xu/v1xHA1R3f4X4YzYlYaS4rfWED+c+L7QbLeKU3sY+KbP730c0oLApXRx0nQxaLsG3JpeTU8zu1ImPzjjVpHis44o+Q/rBqsk6TYZOH0KD4tqQlw7R1lBlLJgvg4A4vkJ0wUi28gbLjhBlu0YRldz2N2rBQ9VlcUtyM9AreTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: 
 AQHa1GEaJrvjQ9LEBEqUr/NOQi8XF7IHAL2AgABrsFCAAFOUAIAALcaAgAd39YCAAsqfYIAB31dQ
Date: Fri, 2 Aug 2024 13:20:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103EDA1B3D8F3AE58921207C2B32@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB61039127C5BDFEAD794823B0C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB124024682FB394D8028018049B7B02@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103BE1BF1587327820363A5C2B22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103BE1BF1587327820363A5C2B22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSCPR01MB12501:EE_
x-ms-office365-filtering-correlation-id: cd3953c3-6c5b-4860-602b-08dcb2f5db26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bGZTV0daRW1SMGxVYXBBS05jcG9MbFJ3cll2cE95bGtiNWZ4WUtMbVZl?=
 =?iso-2022-jp?B?cXM1dkNjWE5rNXQ0TDhsVThyUGZKVk5NQWoxZUIzSDI5YlhLaVdQajdv?=
 =?iso-2022-jp?B?NVpJZCtzcjFKeGNxZFhUZzZWZmRyNG5laVMxZ2lwR05tcDJLMmVvdmk1?=
 =?iso-2022-jp?B?cEpEdjVXcXpoMkd5enVkWUdNYUgrd3pTUFI3a3dtZ3pFV3ZjSEhYWXBy?=
 =?iso-2022-jp?B?b0dPZ3BmMVkwV3hPUWp6bXd1cW9QL1dwaTBQdU9WRDk2VWhwRkN3MDAx?=
 =?iso-2022-jp?B?MkVIdEswTU5EY0xVUkpvbThLN2J3aFd3bEpGS2R2Z1JMUlhLYUZzaVFL?=
 =?iso-2022-jp?B?UkhnMDN3U3FJYXBMa2ljeHJGUmV2TXErNDBoSk9Xdk9qNDU5MXJpM0Jk?=
 =?iso-2022-jp?B?U0xFUGZxaWNzMG9CRy9BRjB5Q0owQmFSVzRTcTVrQ1pwUVp3REJ4WlV4?=
 =?iso-2022-jp?B?SE45aEs2NkRoMDJYN21SZXpNak9Sb2Q3Z3hHMVFVS1I5bXJlSTVxS2cw?=
 =?iso-2022-jp?B?TEpjNnh0ejhxT2habW1seTNRNFE3dFE4SUVocUsyRndsbi9hUFFkSmNi?=
 =?iso-2022-jp?B?U3JCc3JqSTQzaDUyQm9lNVV0MWIrUTJCQmxqU2hhcFVYckN5REJ4ODRU?=
 =?iso-2022-jp?B?cVBKUWdOMTN2V3VhbTNpM013TTRCRDg3OE9aQlBNMFlpZjZGVXpTUzk4?=
 =?iso-2022-jp?B?ZjdPMDZETy9XN0NrZDN5eHBlL1RtMFU5OWdHZXZnTVRmb250L0Y4bE9v?=
 =?iso-2022-jp?B?bkdBTzJXRUhaWXZSL0F5RHA0MmJObC9haExHdStCUVFpWVVWNVRjUGpH?=
 =?iso-2022-jp?B?N2pmcVJXVHdXL1pjQk1YcTYxU0tiaHU4UldtTUhTN0hPdUhIV2kwcDhq?=
 =?iso-2022-jp?B?K0ViTU14S0UzdHVzVzRoN3ZpY2ZwKzErR2pwN2VhV2U3dlF5TUZIVlFs?=
 =?iso-2022-jp?B?SHh2ak54UUIzMjUxVjVkK3JtaVVLMjNoT0REVTNLQnlIbFF2UWZiOVdz?=
 =?iso-2022-jp?B?a0kvemFRdG5BWXZRQVBCNVFiQ3k1LzZuK2JINmFVZkpiS1FxdzhmeVI3?=
 =?iso-2022-jp?B?bFZSdWpTaGpxSDYyaHNIcGk3eVoxOG8xdXIvZmI5dXNWK0tac3dhMTY0?=
 =?iso-2022-jp?B?aUZmSGdWalB4SXU1MUluUTYxWUEwMnpYczFYTzEvMjlSM0RwYWYrTTY4?=
 =?iso-2022-jp?B?L0xmRW85WWNDZE5Cakd1SlZidzZudnhFb1AvYXNSb1FpVGFycWsxOXMv?=
 =?iso-2022-jp?B?OVowM1NMeXQ0MWFQSE94d0N0bzdvRWM0RjZXV29qN1k5MzVROW5LZ1dL?=
 =?iso-2022-jp?B?czFRcVNIQXdBR25Td3p2TENwamhmN05QL29EU0c3dXVDYW5pTExYZzZ2?=
 =?iso-2022-jp?B?bU92MEpxZVQvZ3JpYmM1aWhGRUxSQmFHRUVkK2Q5eVFMOVg2OWxlME05?=
 =?iso-2022-jp?B?bTgxYjl0VzBLMmJpTCtndmkvSmU4bzJNYmhnVzJZWnZ6Mkh3a3EwdkNj?=
 =?iso-2022-jp?B?dkVWV3d5cXNMQy9ENkoyQTBCRU5FdlNUdVhYMWdITW5iUTJhTWFvbmdr?=
 =?iso-2022-jp?B?L0VTNFBMN2FreGJ0UEhlQ2IxTEd4RVk4UkhJajQxZU0vcmNlTm9lOXRE?=
 =?iso-2022-jp?B?UElZQ3lQSll2Z1VDUWtnTDVpRVlYUm85MWtYdXB1aFRGZFRIR2VKcnBB?=
 =?iso-2022-jp?B?TUZ6RUZUMnVORlBhNHhPL0tOdUlqWFdCRUNMOXJ3TzlvNFhMaGh5VjVO?=
 =?iso-2022-jp?B?Y3NxbzJRRndyUnpDRlBGRS8wdm1HMkt3d29CUEFqVUdTZmQ5WWdqdFdv?=
 =?iso-2022-jp?B?VTBFajg5blJ5OHNic2E1bWx2cnFDanZ4aTdLZytnaFpaY0N6NlQ2Y2NG?=
 =?iso-2022-jp?B?WGJPdThZcGIvTlZzYVVSeGgrNVdsL2ZIZWFoZUVLTlhOa21relRwdWdT?=
 =?iso-2022-jp?B?eHRRckxFQ3hSY04wckRhQlhLdHV2MzZ0K2VPTlJsY0N0NHM0dmFqZjJP?=
 =?iso-2022-jp?B?Zz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZWVQWGtvMVQ1blNjRnFQVjBsd2NSTjlIMDBXbTlNd3M4ZWNVMzY0NnpW?=
 =?iso-2022-jp?B?V05UUXFLQ2JaOXBoaktyeTZMQ1hZVHczVjhGbnhralY0MXJVd1lPN1hm?=
 =?iso-2022-jp?B?UkU5OUFXelJMQzhIWnh4US9aWTNnK2RVanNHTExJQWVmb2tZWEtXWktp?=
 =?iso-2022-jp?B?VTV5dlc3MUw4a3lPU1pON1JiaW82bUJkVVBUUXg4WEkvTzhsQnhuTzNE?=
 =?iso-2022-jp?B?UGYweERWMkNEZ0svSXFOVlYvQUZxUTFiN3kway9ZWDhYNU9FdExkRlQx?=
 =?iso-2022-jp?B?VjUvQmhvQUx5SWtOSUtId093UkFCbnNqcEQ0YTh0UVMvUnJ5UlFCcm9F?=
 =?iso-2022-jp?B?RzlOdHJCcUEzZGRBUHhxSjFvKzVjMVlBMUFrTkM2NGhaZTh6dUUyN0dl?=
 =?iso-2022-jp?B?RE1WU2JPd3NReGVQaFhnbDN3RWtJVUxVSkx5SmNQVDJFL2c5a0pNOGhz?=
 =?iso-2022-jp?B?c2Y5TDdmZkVIT2t5amh2UWhVMmYrSmtrR0hLOHh3TklGTTdFTnJxemNU?=
 =?iso-2022-jp?B?TVg2S0x0d2dKdk1SczdubytXQ3phYytYcG5IbGpYOStGTUxGejU4UWRE?=
 =?iso-2022-jp?B?ZTNpVEdyWWVkUjdKRXFFTWozQjhodFFSTUxlVEVqeDVLWFJ0N3MvRDJT?=
 =?iso-2022-jp?B?RWlFWWJqY2JzZ0dMMDdiTlhibDNwcW51YXNuaTlaaWlZQXFOaGk3MFRY?=
 =?iso-2022-jp?B?MWFmekZhWHFaUHkybmFJa2VObVEzakRoWTdIeU96MVhGY0tRMEhDc1JR?=
 =?iso-2022-jp?B?RUZBc0o5M3MwSWFUZlZ2QmZTWU0xeXR6RElGOTVlOEdiUHNMOThMdW5z?=
 =?iso-2022-jp?B?VU1LZlo2NHFWRkpuZ1Z2cmNYY0JBZFRtZ1l1ZDF3S3hISmE2cXVUdHZo?=
 =?iso-2022-jp?B?ajVaSGQrc2x1TVkxWkdNWUdEM1V4RkFLVjQzUnlsM0FoV0JRblc4cktk?=
 =?iso-2022-jp?B?RmFIbjZMSGZvam0xYjdKZGx0ZXdKUmxRdDFXaVNKdXYzaitBcERKbjV6?=
 =?iso-2022-jp?B?dW1qRUhsMTkzcGhuWUgwS3JoaWk4a295LzF3elY1UXRiMnFXaW5Ja3FI?=
 =?iso-2022-jp?B?S01BQUxKVW9xVm9tb0diWDlydGhadUw1NEJjZjRUbjVBSFUxRXA2Ym1v?=
 =?iso-2022-jp?B?OHJJZzlvZnV1OEtKZkJsanhYMCt5QUh6dkdWWXNKbWd0cCt2Tkk2cUNx?=
 =?iso-2022-jp?B?bzU1OUx5eTdDdTRFQ3NTVWlxSUZmQ2hWVGxmUk1JcXlIVXIzUzl6MTNF?=
 =?iso-2022-jp?B?a05vS093cUhoRnVXSWdGSEZPWmYrUGpBMkV2T2IwVmYva28wZFVLSTc4?=
 =?iso-2022-jp?B?MTBPTCtvU2hvS1lSd3NxTUloMy9sd1NrQjdhSkNQVmRNTmFGNG9OeUQ3?=
 =?iso-2022-jp?B?SGR6eDVHdzkxQVNTYVRxMDlBK0xaSzlkb0JFeFFpUUFDQUZmemhFa2c4?=
 =?iso-2022-jp?B?enY4dFErZVBzcnEwNE5VTURrU2ZqN3NLYy9UN1VEdGhRM1c1cFVvYllQ?=
 =?iso-2022-jp?B?NExqYjkxYXFVclhkc2J1UldRcEVxNVM2QjVLSWNadWdiRU93c1kxZCtj?=
 =?iso-2022-jp?B?K3N1LzgzeUI2TUV2b3pMT3UwSnZMYWoxbTZYSGZsMVJ3K2xGdDFMZ2cr?=
 =?iso-2022-jp?B?QXZhZDZONXIvYVpGRVhwMGVmQUVZaTE4R1JxSExJa0t4Szc0bzNTZUZL?=
 =?iso-2022-jp?B?a3R0bzFaMU9XcmNvQmY4OGZ0TDJKeVhzWVBkWkpwWnFhaEczbllUWGhk?=
 =?iso-2022-jp?B?ZS9FWHdWM2EyV1RMTG52clg1V3RSbHNrWHovZFlwNm1JdFR6bE5iMFhO?=
 =?iso-2022-jp?B?Z2NZR2VPWmE1ajc2YXZjSHVqejNZY1RrTlQrMGo4eTJLQittZWR0RUdD?=
 =?iso-2022-jp?B?VnduV2FxbkpwRDh0V3R0N3NVYk5tS0ZwVEFDOG1iN3ZQWEhpTXdvdHQ2?=
 =?iso-2022-jp?B?UEFoUkxQcnZLQ1EvNUdPMG9kTmhaVmd1c1lSTFJ6Mkd4T0ZRSlFQN1lV?=
 =?iso-2022-jp?B?NndLbkQwaDV2ZFdnZmpuWEdDS01ELzZoaHEyODdPdzV3bklKVFVOWk96?=
 =?iso-2022-jp?B?NkFCUUp1a1F4UXZ2S3dMdTE2V001cndZNG1PV0JYUHFrZDRuWXE2N1BL?=
 =?iso-2022-jp?B?VmFoUVpsbnIzTjFtVCtpWkZlSFY3VS9DZ3ZreWVyQmVJQ09ZZ3l4OFlJ?=
 =?iso-2022-jp?B?Y21GcTd1UjJYOWlVOVBKNzRKQWJab043VDl5VVRKM1VsdU94dWtzNUVa?=
 =?iso-2022-jp?B?dzdXbnZBSGdwaHRxRk5HQzBqMVZBTHI0eWdJdVFKWXpta3hJMTJmWTUy?=
 =?iso-2022-jp?B?U2s1NWVCUmFKYVNvOUZ2eFVvSmVWd0NjK3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3953c3-6c5b-4860-602b-08dcb2f5db26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 13:20:19.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qwAyfie2Jv6x9e3wsv599V3C74l+ficp0tlW5q8YLe6SwdY8qYecyOqlP8X3SO/EJxIVub9IYFCL93opzvLYjDmqBDkeVTx5osKiLMvrf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12501
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Aug 2024 13:20:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16711

Hi Chris,

Hope you are doing well.

Today the reset issue happened again leading to a login timeout failure ->h=
ttps://lava.ciplatform.org/scheduler/job/1177442. In case this repeated iss=
ue occurs, it occurs only on 'qemu-denx-01' out of all devices with good he=
alth.

After the login timeout failure seen in the job mentioned above, I re-ran t=
he job immediately and it was assigned to 'qemu-renesas-01' in which the jo=
b was successful https://lava.ciplatform.org/scheduler/job/1177460

Strangely it is also not the case that all CIP Core jobs are failing on 'qe=
mu-denx-01'.

Regards,
Sai Ashrith Sathujoda=20


-----Original Message-----
From: ashrith sai(=1B$B#T#S#I#P=1B(B)=20
Sent: Thursday, August 1, 2024 2:03 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Subject: RE: Sporadic failures of swupdate tests

Hello Chris,

This issue is seen not only rollback cases but also in normal software upda=
te scenarios. Example: https://lava.ciplatform.org/scheduler/job/1176650

I see this issue happening in denx and siemens lava labs. I guess there is =
some environment issue in their lava labs which is causing this system rese=
t.

Regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Tuesday, July 30, 2024 7:19 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Subject: RE: Sporadic failures of swupdate tests

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Thursday, July 25, 2024 9:01 PM
>=20
> Hi Chris,
>=20
>=20
>=20
> The issue I have seen in my local environment is regarding TPM errors=20
> where sometimes I was unable to boot due to =1B$B!F=1B(Bcan=1B$B!G=1B(Bt =
decrypt /dev/sda6,=20
> rebooting due to panic=3Dboot argument=1B$B!G=1B(B -> https://gitlab.com/=
cip-
> project/cip-core/isar-cip-core/-/jobs/7326477318#L124
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-
> /jobs/7326477318#L124> . My local environment is not LAVA environment.
>=20
>=20
>=20
> The actual issue which I was mentioning regarding ,
>=20
> >> For example, In this job
> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667> , it can be=20
> seen the system is being reset multiple times in the middle of the=20
> boot process, finally leading to a boot time-out error.

According to the log there's no input from LAVA at the point of reboot.
The log is all green, which is showing only the serial output from the DUT.

So perhaps the qemu machine is rebooting itself?
Or perhaps there is something wrong in the LAVA env, but it seems odd that =
it's only occurring for the rollback testing test jobs?

Have you ever seen this issue when not using the tpm or swupdate test cases=
?
We need to narrow down the specific environment where this issue is seen.

Thanks, Chris

>=20
>=20
>=20
> This issue is occurring quite a few times recently and I have never=20
> seen system getting reset multiple times in between boot process=20
> without any trigger evidence even in the logs in my local environment=20
> while working with CIP security target. So, I suspect it might be a=20
> bug in LAVA. Do you also think the same or is there is any known=20
> limitation causing this issue ?
>=20
>=20
>=20
> Please provide your opinion.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda
>=20
>=20
>=20
>=20
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Thursday, July 25, 2024 10:32 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
> Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
> Subject: Re: Sporadic failures of swupdate tests
>=20
>=20
>=20
> Hi Sai,
>=20
>=20
>=20
> In your email to Jan earlier you said that you've seen these issues in=20
> your local environment. Is this local env also a LAVA environment? Or=20
> is this issue also reproducible outside of LAVA?
>=20
>=20
>=20
> Thanks, Chris
>=20
> ________________________________
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-=20
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com
> <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> Sent: Thursday, July 25, 2024 1:14:43 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org
> <mailto:cip-dev@lists.cip-project.org>
> <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>
> >; jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
> <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com> >
> Subject: RE: Sporadic failures of swupdate tests
>=20
>=20
>=20
> Hi Chris,
>=20
> Currently Swupdate, Secure boot and IEC layer verification jobs are=20
> running in CIP LAVA Lab from past 2 months. Recently there are some=20
> issues rarely seen while booting the image where the system is being=20
> reset multiple times during boot process leading to a timeout error.
> It is not like that particular lava slave machine has an issue because=20
> the next job running on it can see successful boot. This situation is see=
n irregularly.
>=20
> For example, In this job
> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667> , it can be=20
> seen the system is being reset multiple times in the middle of the=20
> boot process, finally leading to a boot time-out error.
>=20
> Do you have any idea about this ?
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
> -----Original Message-----
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Thursday, July 25, 2024 11:46 AM
> To: Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
> >
> Cc: cip-dev <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-=20
> project.org> >
> Subject: RE: Sporadic failures of swupdate tests
>=20
> Hi Jan,
>=20
> I sincerely apologize for the delayed response. I observed these rare=20
> TPM errors even in my local machine during development and testing=20
> with security target even though we made sure to run one security=20
> target at a time on one lava slave machine to avoid any TPM related confl=
icts.
>=20
> Currently I do not understand why system restarted in the middle of=20
> boot here -> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667>  and this=20
> reset is happening irregularly at random times during  boot.
>=20
> As of now I believe it has something to do with the state of the slave=20
> machine on which the test ran in that moment. I went through the list=20
> of all the unexpected failure jobs till now. Some of them came under=20
> 'LAVA Bug error' and most percentage of the failures came under the=20
> category in which system reset is happening right in the middle of the bo=
ot process.
>=20
> I will discuss this point with Chris, and I will let you know the=20
> issue as soon as possible. Once again sorry for the delayed response.
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com> >
> Sent: Friday, July 12, 2024 7:10 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: cip-dev <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-=20
> project.org> >
> Subject: Sporadic failures of swupdate tests
>=20
> Hi Sai,
>=20
> where are these tests actually failing? The also reporting that they=20
> are unable to clean up the jobs properly, but we rather seem to have=20
> TPM
> errors:
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732647731
> 7
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/732647731
> 8
>=20
> Retrying them sometimes "resolves" the issue. Can you check if there=20
> is a way to improve reliability to avoid any false negatives? Or do we=20
> really have problems here?
>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center


