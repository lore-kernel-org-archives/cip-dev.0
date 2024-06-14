Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E53EC27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 05:24:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.4475.1718342639310592916
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 22:23:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=kG5H1L5G;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1718342633;x=1719552233;bh=vjZSTPMCC1APi4Ws9r8KsOcU5Z33jALnd1AOi+U
	bQVg=;b=kG5H1L5G3rmUC4/C+cGgceiNgLuK+8QdrQ0T9Jo+G6jL1X8SLMC18vW9can31WXgonybi
	P6de56KU6TAoS7acVZsZy5LfYSc8brjLLoJPjrHDQCw0BiPYMgxXyf4HkoEs9/icbkPSRtfvaF27x
	PSCsInFkTjvNYXFSek1Qvuhkm2r2xjzCaCiCnegn042+Y6XlJsSIpHJNb0dju0BOzeIdfUVDnsy8s
	67OvkZk2AC8YmrQnCUUSBD6fm8XCl1d6zdSP6LENV9eBE1HZcwbPkMQvF9VJ7YBDm5n53bFsNIeCQ
	RCjm7jATYMKX/rXF+cofGSvnVKNFRPZwGwF+JG/xUg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45E5NrFY975125; Fri, 14 Jun 2024 14:23:53 +0900
X-Iguazu-Qid: 2rWhNMNedJhXXksL7g
X-Iguazu-QSIG: v=2; s=0; t=1718342633; q=2rWhNMNedJhXXksL7g; m=4QbfW72ZD1UYo8os380PN+T2zFEsdsH9trWypLUGOAo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 45E5NqKD2159627
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 14:23:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNyVzMwtqkLPJSBuE9jkQ83D9ZqmqR56nVBP6eIq6FevzWrCzOMa3QT5j9HF2N1t5NE12W5QWkmD6AqrDOwye9Q1EIKAU9dVpUEkVcZgwq+OklCcPo3yK1Fj+MAL+qbQe8rhwSnjrrAhBvWMgpxSc6xynhhSRPsLR7cpbEH0pAgQbjfkQ8fH5r0aiC0bpQyNpKqJaS7MUqVNE/zc14W+csW6cRVTPRjz7ElsJeG7vKLfAy0WT+gPmYN/EGQY7JvgUUL4P3sOcIfQAej5djVDf1VFpV0rxlKbaqlSflSwFH/5IDRSCksORO+KB+PTe8gXWPWpMMCp8I7A3pZKXepDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XgQjZlNVDHwyJZH913Ae8NIfEgGpPIAMIZ3LPaPjb4=;
 b=lkT6XAIHCMs6Jcjqnfdd7sLsVQNY4MMeZ+TfSSLy9Ob+m0oERFh7AascPiV2CgWhKV5YxTr0550SCUt4FNZxFNNrWxauiwXbKMdMhRHyOZV/s430zGHo6hWL1OPvhzFipC26H/tSHFW3IX7bjQf0KsDViGGYOlrmbQZ7d6Z6Xo9t/cUNSxwMFKfts1gvQqgizmoKmRE9xrcnlnc2YSjnajeYSCsS1WzPSxHrtn57KdXoiUJEPxnDlF7la/WBmLnGOBWbzX+am33U8smCXd7o0RgoFP21N9gzcPs9NX39jAxZGHfvk4ulpqHWPB+u6F7iRB1fSptaGoSNp/iJkMby9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/7] Fix USBHS pipe configuration
Thread-Topic: [PATCH 6.1.y-cip 0/7] Fix USBHS pipe configuration
Thread-Index: AQHavX7Bl5RXqrruoUqSDqxAssjzhrHGuvwA
Date: Fri, 14 Jun 2024 05:23:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638888EC53BD628A80B32F2C92C22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYRPR01MB12143:EE_
x-ms-office365-filtering-correlation-id: 911c8d94-4464-4586-1667-08dc8c322c9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230035|376009|1800799019|366011|38070700013|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SlFQZXM5YkZJT2RYdkNZUkpLU09pRnJpVjA0cjRVK1NROVFOTTZpZWVL?=
 =?iso-2022-jp?B?aGVUWHJ6clA4OWZXa2l0ejNnZjBnY2JhMXlUY1pYZWZNQ0REZmEvcWhj?=
 =?iso-2022-jp?B?Zm9icWk2THMvVzZ4Q2NSRlN0VHNJTFoxMkxLYXlCWE8zcUd0dkFkaThs?=
 =?iso-2022-jp?B?aWtFVWNpMXlFaGNXcGgreWJxZTFFbmNadklBTDRycEJJY3orNk5LQ0d5?=
 =?iso-2022-jp?B?bGNLYTUySml3U2hSLzdtZkxCS1JpalEvVUtwclVZOHhGdnVac0V5MlFY?=
 =?iso-2022-jp?B?b0h2RzNDMjRrYmt6Vk11cXFXRVRzdkMrVkM3QmExNGVlTmw5d1lHS0Ix?=
 =?iso-2022-jp?B?aDE5cmd4QXVJMU1JU0JsSWxUVVBSMXg2ZVB0cUlzOTg2OG9MYTF6bDJK?=
 =?iso-2022-jp?B?VkI2aEJWMGp1cjRGY2NtQjhGR212N2Z5K2s5K0xYaHlCU3QzQ0kybkFw?=
 =?iso-2022-jp?B?YW5PbnkzZGtLSlA2V1Z6OHRrUWVnNlEvR2swN0hTS3lGTE9HT3ExbU8v?=
 =?iso-2022-jp?B?aEhkQm5sbityK1U4K05HTkdwdnMyamIxbTBuZlRWK0kvNG5oY0N3c2xy?=
 =?iso-2022-jp?B?YzAvSjJBOHdsMU45WGsrZEFISmlkZXo1TUx5RFU5SFdqTjdLa0FzMVRK?=
 =?iso-2022-jp?B?ZlFLaUZYZkJPS21yL1pibHRSVXhURnlmWmxIeGVSblZULzVteGxQU29R?=
 =?iso-2022-jp?B?bFBXV2pVMDNvaUFPb0pVV1YvTDJUWG04eHprZWRYaURLalhTNllMOVBJ?=
 =?iso-2022-jp?B?cjdhQmxCTFpmRWtocTBkMkxhTDJmQzJVVjdKVU9sNlRLR1pLK0ZKUy9k?=
 =?iso-2022-jp?B?THpiUmpiR2F2Z2tERkw4YUtmUXhKTUEvYlg0Z09UbkV1TWhMcVIzL2tl?=
 =?iso-2022-jp?B?TjMySFJaOTcvbFJ6bXEwVUlYSmx1RUVPN3NnT2tsbmhlY25weVVmRmZn?=
 =?iso-2022-jp?B?TGdZdVpWdnI0bjBKU3JxY1lCbEp3K2tHcGN1ZndVc3BjS1NueDF6ZWt2?=
 =?iso-2022-jp?B?UzlnMXU5ZEFVbFFJNllZU2d4Z0cvaUVlL0RHK3daN3BOb3VrT0ZjUFd1?=
 =?iso-2022-jp?B?ODRGNFE3KzR2U1E1OHRKNFc1b3NVWXZkU0Z4RE96NWw1Y1RjRzN5MHd1?=
 =?iso-2022-jp?B?aTVRZmZYeXNkQ3VFVnlkWjF1SXZhdXFQUmdtd2VJMWNkOG11ckN0L3BD?=
 =?iso-2022-jp?B?TVdVaFB5UDhESzJQdEdGWFhrc1N0WnEyS1BFaVVtOUdKcmNzaEZQdkZX?=
 =?iso-2022-jp?B?a0NxZlZWL0lSUDJkQ3BnSC9iaUlsWk9vRkFIQVdLN3NNcXgrOHFwb1B3?=
 =?iso-2022-jp?B?ZVYrbG9mWjY5dFlJNVI2MmJ6OWx1UWNJOWw5Q3kwZHFQTFBlQkhwbDYw?=
 =?iso-2022-jp?B?TjJCOWFOUW9aWW9xWEoyaGFLUStvVGVSS2swajJ1K2hFdHNqYldtY20z?=
 =?iso-2022-jp?B?SG53TmU0OUg3bis1eDUydjVhOW0wcmhScDA2N1hqcTQ1SGZaTjhZdmxX?=
 =?iso-2022-jp?B?VHhYcjJSNllRcFRxTEszbzhCK1dJcTRFZXhQbUpUZSthZ0R2akJWUzRT?=
 =?iso-2022-jp?B?WEtqbWdBQ3FXQzZ0UjVSZzNGVkZLczNEcDZkd2hlWUVVazdLVHJLLzJz?=
 =?iso-2022-jp?B?eUNYUmRHUGZBVEZKZHFndjc3aTZIUFFvdG9qc28xTDNUblhidGYrMExJ?=
 =?iso-2022-jp?B?NG5jZVJFMC9QRVYyMDZqdEJxbjZqTmRja055SnBVZXdMWGhaakJOZGVi?=
 =?iso-2022-jp?B?cjgrV0xWZ240YURGUUgya1JlQ3VNSXJMa1lUdTRWR1lFbUZhTllvTEFE?=
 =?iso-2022-jp?B?a0hlNGR5ckVvTkxpT2pkZ0NnK2t6cEg1ZytITFI2eDg5am1kTmtUNm5j?=
 =?iso-2022-jp?B?dGREb1EyZHk5WllTNVRiTGZwM1M2b0VJNnJHYTZHTmtXd1dHMWtXN1dr?=
 =?iso-2022-jp?B?dEJTODI5UXVmeUtxQXlpTGgyU1FSR2tRNzhkbHVLdTRBQUxZSEh2alhF?=
 =?iso-2022-jp?B?QUd5dElQMlBSNTdJdzdjc0R4aCt6dWxNTTlwc0Fnb0lsdGw2UDlBczdS?=
 =?iso-2022-jp?B?UXc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ODNQbnRtaXN2bmxyUDhldU9uVWpZTG11TnhOZllrNU5hVzBPa09qWUdS?=
 =?iso-2022-jp?B?NCs2RUtKbHd4b2ZMckZvUFM4RzU4eC9xaUx3Mjd3YVNyaGJoNGtLMmZv?=
 =?iso-2022-jp?B?MWZxejQ5dmwzRlhMbHRJV21GRlJBMWlaaDRRT0R4UktiUnRsRzRIcmcv?=
 =?iso-2022-jp?B?ZjRGVGNTMGdlN1BpZkNsQXNsQUd6SnE4ajE0d0lUMkMvRUVyUExiZSt4?=
 =?iso-2022-jp?B?Nm4wRHNIZkRpY3FRNDVBdGsybjhyNkk5K05rMTNXWlRKM1VLS3MrMWNH?=
 =?iso-2022-jp?B?RGZ2YUNHYS93Q0RKaFpmdFI4SVR6ZWhKWG5BSmllMitTSVlkUXoyeWdH?=
 =?iso-2022-jp?B?MkdnQWJ3UnpYVXFxRVAzK2h5d2R4aGZHL2ZjeEZQU3hYVXJQd1JZWE5C?=
 =?iso-2022-jp?B?MUNMK0liMVJZdHZ4WW9FVnF4L0xFTnIvN2liME92MWIvckpxT1YxT1Bx?=
 =?iso-2022-jp?B?R2RTOVlwZTBMWEM4OUl3VDRnNzVBcEZua3M2enM4elpZcDNVZlFGcEdL?=
 =?iso-2022-jp?B?amtaNndxT3ArMjBjWlc1STUySHZGWjVYUE1XZUwrREs2VDVWWm9tbzNP?=
 =?iso-2022-jp?B?VW5PK0VFaW9qcTVmT3A4RlR2Q1VrbzN0eTEybk5Bak9JeGJPeHNlYTNF?=
 =?iso-2022-jp?B?K1ZsYXNXYjdIMk1aendwVHZ3VGxGSVhFY3Q4YllTbXhCbGhZZE8rY2pU?=
 =?iso-2022-jp?B?ekV5eVY5ZWlPV2l3Y0FDamFxbnZSN0IyZ3YxNC9mR1J1bDhBSzZSNVo0?=
 =?iso-2022-jp?B?NVI0bVRzckZ4SmQxZGVsTWFRa1lzakpPWkdNd0ZYc2RMaUloTVZMWnJT?=
 =?iso-2022-jp?B?cFJIUUxCbVQyRFBiTEZWUCtXZHU5dXlDUmpMOE9rOHJNZ2IxNnhOTUl4?=
 =?iso-2022-jp?B?THhFM2FHTVBFbHpvQ2JrdDBISjNsWXQxeWdOeHdLeHdVZVVqWHUzZGdT?=
 =?iso-2022-jp?B?TlpKY1dJbENHZmpLa3RpR014eUYwbEVnUFRDVlNIWEdGZForVTVEdVY4?=
 =?iso-2022-jp?B?bWlLVXZrVmtQaTE3ZkdwdU5LcGpKQnlZcVhxd2FWdVpYQk02SE9GaVJp?=
 =?iso-2022-jp?B?WFVOYVhkSURzMEM4bk4rTWczbkRsSExhYmFoWTg0ZVNRVHVzT3JpUHBC?=
 =?iso-2022-jp?B?YW94Y2ZnZVZYMGcrOUhldVNCYnFsMEF5TG1VYmhtcGY3cEU2aXFDU1Fa?=
 =?iso-2022-jp?B?N0dOSC94QUdtOGc4REJBWnc2VURDN1k2ZFdsQVMvNGRzcTVKK0Y4Qm1h?=
 =?iso-2022-jp?B?c2xZME5XWndPaXJYLzEvNFl5YVVMNm1RSGhLMmpYZlpxWDN4VkF4K29S?=
 =?iso-2022-jp?B?aVZnVUREY3hYcWF0Tms1bmhsWnJDamt5ZTR5RXgyZGl5VkJLZUpDOUZo?=
 =?iso-2022-jp?B?OHFPdzQvNkw3d2ZueEtjamxjSWV0ZmI4dFVNQTdtWnowdUJjWkVWYmUx?=
 =?iso-2022-jp?B?Nkk1d1NzZ2lodFptYXN4UFhrQjJYYXovczcrRWppNjJyVUgzZzJmdGdu?=
 =?iso-2022-jp?B?dWZoYWNvUzcxbmlEbmNNZnhsblZhaHFTUTA4TzhDUThnNW9rSGk4clgr?=
 =?iso-2022-jp?B?dUdUWFNqTmtUWmZmL0gwb1pEdnFSSDF3KzdpWjg1Z0Fyejh6RkVqYm1s?=
 =?iso-2022-jp?B?N1U1RGFCTFBmcGpZMGpvUjN4NVJJY1Z4K3o3UWtzOUVaVXJGM3Q5dnMr?=
 =?iso-2022-jp?B?NkVRRkNVQ2pVOVNBYkprbHNDNUkrb01PNElFWXIyRkNwRVJzKzVrOXJI?=
 =?iso-2022-jp?B?V2RneWF5TUJYRmIrcS9hMUpMR3N5Z0NJOUFocTZKU2h5d2JOM2s3UHhJ?=
 =?iso-2022-jp?B?M0pSMDZqbDdjU0NydWVMcmRRcmdCa1gxMFpLeHkzVXVKbkMzbVlKOUlv?=
 =?iso-2022-jp?B?VmVrRHFrK1c5RWNPVEtkckF4WXF4cVN6YUEvc0UySjlMRStXQ1lZbWdL?=
 =?iso-2022-jp?B?NlJSVjYzS1dmNkYrcEk2ZWpYNW1mTmx2aGs0aEErV016WnFseDdTMGN3?=
 =?iso-2022-jp?B?eThPTXpNaGRVc3Y4VE4wOVNxZVd1S0xKN3ErL09DT1J6ZWJsRHBkN2ow?=
 =?iso-2022-jp?B?ZmVoNm9ZWWpZZjh0TWVSb0xRVXdHV3JUNEJmZ3lmVGk2MFFGQldVKy9X?=
 =?iso-2022-jp?B?RlhlanFkaHcwRmNjWDkvVTRtYzJtWFpkZW1jdWtnV3VObUhPUkVZbi9N?=
 =?iso-2022-jp?B?MElWZ2J0TEc0UFFMdjFldlFzNDRJTzl5WTFFdVBPOEZsRi9jbEdnTVhY?=
 =?iso-2022-jp?B?MklKcDNTeW44QnZnNXhwQXQyS3M3bE5sZ3hTMmU4RGkraWQ5aXFlT1NN?=
 =?iso-2022-jp?B?U3p1ZTIvTDU3U2JkTHppRGZBS2wxQjF3WWJFWDZaT1VmWmdXOGgvdGdq?=
 =?iso-2022-jp?B?TURpUzZOVUJJSFNURlA2eWs5Zmg3Vk1KVHFLdGRoZ01IK25zQzU0MWpJ?=
 =?iso-2022-jp?B?QWVTWnFtTER5SXVSSnBQWFE2MHRaUCsyeSs4PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911c8d94-4464-4586-1667-08dc8c322c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:23:50.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pasWisFJcr2zcOJcaLWxMrzQMfHUbg3INw24oUH+5z+0plKpRdYhatA8fRRSjCVXBSVng1N3S47HpURnnz3hP6ebcZv/rH4AkZdK/TPhkkE+xhAb5+PZIRTx4p57EFw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12143
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 05:24:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16226

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, June 13, 2024 7:45 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/7] Fix USBHS pipe configuration
>=20
> The USBHS IP found on RZ/G2L SoCs only has 10 pipe buffers compared to 16
> pipe buffers on RZ/A2M.
>=20
> Fix the USBHS Pipe configuration
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (6):
>   dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
>   usb: renesas_usbhs: Simplify obtaining device data
>   usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous
>     transfers
>   usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
>   usb: renesas_usbhs: Remove trailing comma in the terminator entry for
>     OF table
>   arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family
>     compatible
>=20
> Lad Prabhakar (1):
>   dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
>=20
>  .../bindings/usb/renesas,usbhs.yaml           |  8 +++-
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  2 +-
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  2 +-
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  2 +-
>  drivers/usb/renesas_usbhs/common.c            | 41
> ++++++++++++-------
>  drivers/usb/renesas_usbhs/rza.h               |  1 +
>  drivers/usb/renesas_usbhs/rza2.c              | 13 ++++++
>  7 files changed, 49 insertions(+), 20 deletions(-)

I reviewed this series, LGTM.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


