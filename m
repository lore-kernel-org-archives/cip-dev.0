Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AACE6FE4B
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 21:49:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.10250.1725659341952901101
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Sep 2024 14:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=nH2J/lnI;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1725659333;x=1726868933;bh=x+AuXmz3o1WrJaiUjjdmFAOAv1P7TRk62gqVvZJ
	eKxQ=;b=nH2J/lnIqMFXuGgL06EV1bTc8b37KVAnzv9Im3JCjQ7PmhdqF2aik0DA8jdrKGm4xHnLx
	VBLbvCepSKa+iuDjN36+SrBlxy5ccbno5x+lVvokNv30t37EFtF19wuHrkKIOL545xz9YIJTy8AeR
	M3D5cu2R4De+irUjLAvIUmS6vbASxCrzmeJ5YaYxd6iE8YdpZCmDWf82aQN8XdC1XHSa1jX2LX8fA
	cvGOljMptB5xEDT+qCD8howzSur4enYww6P73PNcrHJK+wngsv8sRZXlxnjwZv0Y1Pyo4sLLgJsB7
	sUDG9GhxUfgp2ppCdnwue8ihPm2o9SZWtPBtoJVaig==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 486Lmq1i2925797; Sat, 7 Sep 2024 06:48:52 +0900
X-Iguazu-Qid: 2yAawTGyO5IasB6mxu
X-Iguazu-QSIG: v=2; s=0; t=1725659331; q=2yAawTGyO5IasB6mxu; m=j9OkpZadq06nTCszdNf2X2mXHZPwa3LNm73cS8UuRfw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 486LmorO3644847
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 7 Sep 2024 06:48:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN2d9o1qIycCess3MeRrhuzE7DnWhMx1vq0VQF3FCHRAXx8XRTWdB+ohzuCA65jP/5dzHkfx/o1TJwMZ+9DvBfEO+9huKgUlZJK1pCo2qOOl8ERFKu1bMFyxxIpM6sMqVIENJXz4FoCPNxBaUVjHlUuKsGEc2c0UEkOhS27pK+a1z7gtPWSwSQRjmnewTugyGytEAq59U7Fmv6qNNdA/xCtQVbLZfS/6VM85/tG1qG8QguW9CcCps+EZ2HNEMvlEAwyUFhESdMP0cE3whMy1RouJOvJ5ZMImguQFjMTlBmAk5cQZJhrSUYC8gqubpg3pHi0spnT8YZz51RrmaoxhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw4SJ4d2SmtvjgUGkEY/YgXa1buRUz5mnodXEXoDM3M=;
 b=miunBBh2GNMfS7y55jEqEkQmdarBd1slLyh5/u68BTAtO1WfGPbauexXKeG4nGiXR7wn+7Yt79WTXzF7f6AE3+a8PGRZc7k2ZyGIOcXJaAupmYbyaYQouyde+siLhOQNHu8TRWngL7PVptnMyfjjP9DKOmIoPFLRYNURkxXTQt0E3kfqtS4vR1BPLrD7y12IhRUaYqhuM9pGMlKp0BkfcN2y/fMIWFPHq9spuFh/USpeg21FdwyHt2SH/nFD7mTc4Bdq2NhOOhioVBDgcyB2huWQlHB1O8oukeP7zKxgO5mf9Bpf6pGd2/leSrZ7Cxl+HRJYs6KDfRzP7EePq30Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 6.1.107-cip release
Thread-Topic: 6.1.107-cip release
Thread-Index: AQHbAC8HGLdMoGolZEifqGcS0srzXbJLSTFA
Date: Fri, 6 Sep 2024 21:48:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388BD6095E8058C2675DC39929E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZtqwJfVY1s49vSdo@duo.ucw.cz>
In-Reply-To: <ZtqwJfVY1s49vSdo@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB11379:EE_
x-ms-office365-filtering-correlation-id: c996efc0-28f5-4657-bfe1-08dccebdb062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Unp2Q25VM011VThKVXEzVmV6UjNlV1UrM0lVYlpQWFl1THBDTGpoeloz?=
 =?iso-2022-jp?B?OFMwbGFJM3hTc0J6NFhOQUpieG1ibDYrKzViWGZSbXBncTlCanF6ZEpp?=
 =?iso-2022-jp?B?Um44UXhjdzAvMGlsREdjbEg3OTl5UmxiOTQ0V1Vtb1llUWNLRW5RL1d2?=
 =?iso-2022-jp?B?UzlIbFhCU1ZFa1lNWTU3dFlNNVBGZXJQcmpxU1YrR0tUYkI2UlJIWFN2?=
 =?iso-2022-jp?B?SmZROUVOZXBxR0hzdDQxRHVRbHlPSUwvZWc3T3dnS0pCNk81VWFzc3kz?=
 =?iso-2022-jp?B?M0QzNzdtNTlwVGdmZ1AwM3B2aEsrSEpjRUtsUUdGNDhHRDRkZXlXOEF5?=
 =?iso-2022-jp?B?MmE5TWpYSDVUM0lkZkx3SFc0aHJubUNJNEMwK0hHbzN5WWs5alBjS0Jm?=
 =?iso-2022-jp?B?N3VYN0dMWVRVamFpYmNjd21WektkLzhNeHNoZVBxQnFpbmtWa1Q2UGxM?=
 =?iso-2022-jp?B?U1R4WkZCNVlIbWxpOWt6ejh5YnlaV0UvSTB2S3lmZTNORHBRSUJNay9h?=
 =?iso-2022-jp?B?TkNFdG10ak1iYnpYYmNQUUFRTnBpY2lTNWV1S2ZCcVRmNmxXZHlpMHRw?=
 =?iso-2022-jp?B?VjA3UGdlbnRYVmZKbmtZSGpIQVpnQzArT1ZVRVhkTWJMbDRwRFBsMHVE?=
 =?iso-2022-jp?B?ZXV5WnBxMkdhVEVHb2tuYm5ydUZCQW1qNnc0ak9LM1B3N0gyNDhsdFh2?=
 =?iso-2022-jp?B?Y00xTlgwV2x6dFNHTFNoU2xJMzl6aTNzbFRPQzBBTWlSZHlEdDgrMUU5?=
 =?iso-2022-jp?B?RXJ1WUdqMytOdlVTZW1OQzZYeWFZZ3Zzc2kzcHhqdmFtcEhNd0hNK0Zn?=
 =?iso-2022-jp?B?eE9KWFJ6UFhSaHI0eXJCcllPNVFyOHZ2TWNLdGZOdXBvRFlOdXBoT3Ix?=
 =?iso-2022-jp?B?MEpCTFR6RFhtQlU1c1F6VGdlYktDWUdnbERpSkkxVDZLUHlUWW4zZ3Rw?=
 =?iso-2022-jp?B?ZVJTdWNSTitBb1ZlQjZ6ZGJlZ2MzUHhCNTBLdU40dmhTY0xzWmRtMU9m?=
 =?iso-2022-jp?B?eVgwVnM0TXR0SFlFM2RPNnovTXN2K054QThmVjgyMWhEa0swT0c3S1FG?=
 =?iso-2022-jp?B?NlE1c1dnaktSRUpGN3dhZ0dTdFllcnhBcTRDYTNTNi9hdUxURWdJM3Nz?=
 =?iso-2022-jp?B?MlAwRWJUNXF3U05BY3RYQnZYemRITm9LSTZvalV0a25PV2pIT04vSlBn?=
 =?iso-2022-jp?B?WkNlY0FabkpnYzM1dUZGUHFodE5YSkoxTE1ZUE5ZK2lGNGNUSm1TZXAw?=
 =?iso-2022-jp?B?SmIzZmRvYkdQSXdKWWZOL2dldU94TSsyYmd0Y1Z2K3JlelhWWjRDVmwr?=
 =?iso-2022-jp?B?eng3cVlKK1krQURzZFQzUmJ3N3VDbWc1QkNkWnZKa2FRUHQ3YTNDM2tv?=
 =?iso-2022-jp?B?MkI3blRFWFlmQnRORUpBVFJReHc4S2ljZHVndUIrUytGYVRNemtUcmVZ?=
 =?iso-2022-jp?B?eXYzaEZJVXovUllzUTlYZDZWOGJLZkhBR1JhRytWK0F3TVJJWSsxNUdW?=
 =?iso-2022-jp?B?YWhvcWV0bXMxakVIUlh4cTlYMWdEZklqQllDWit1czJ1am1NMHEzdkNP?=
 =?iso-2022-jp?B?NDZ1UjlxWnZWOHRoR3FrSjE1Z3VoQzl0Qlc5Nk9qMkV1NDYvdGRlT2h6?=
 =?iso-2022-jp?B?WUNiZ0hjMnZmVUswcjJNQk13SUkrQ29iQ09CQm1kMyt6Z05Ba0lRSlZl?=
 =?iso-2022-jp?B?UGxaQ0VKNi9SZzlXWkw5N21COWh5RGcrUThVOGcwMElSOCtVeGE2Y2xy?=
 =?iso-2022-jp?B?Z3p6Q1J1Vkl4WFZmbDdBVUtEb3dSTFppc1EvN0V1SGkzSlVpbGZJbDNj?=
 =?iso-2022-jp?B?TndBR2JEcStudk5SRWVKUUZRMzA3djY2ZHB2OUtQS1JxT2lTdEsvUkxX?=
 =?iso-2022-jp?B?bVJ0UXZZandpQ1hvTGJHclkxNngydHFFNmVYWk9BcDY1dmRldEVtWVpi?=
 =?iso-2022-jp?B?QTQwMnhVUmpUMjl5UjUvM25PWHc2dHIwa1lFbFlsV2E0RFMrL002eDNn?=
 =?iso-2022-jp?B?N2tnUGEzZytEQW9CRVlFZkU3bVlNZ3ZIREhUSG14TENqdGtya0NuYWU0?=
 =?iso-2022-jp?B?SEljNUFpaG9uaHdPZlZCVlV4Y2dvazA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SDJrQnJUNHcrdytSaGtoYUtra1dHU1htenNFK3hhVlFaYUZZNkczMEt2?=
 =?iso-2022-jp?B?bFdON2psQkJYcG44WHV6U2p3K2dRWHJNb3oyMHYyTmpieFBzOXQ4cmJl?=
 =?iso-2022-jp?B?Y0xjNW55N0VsdUJVZnk5R3U2WGxDUHpWbW9EQ3kxZFRiQjNHcndLMk03?=
 =?iso-2022-jp?B?MGc1UGdFaXpXa2VUdlhVL29nR0kzVXA5YVBQMW9MZDJVak5mVG02SHFJ?=
 =?iso-2022-jp?B?dmMwTU11Mzk5UDNOZEZDZDZNWXM5MEVJTENFUURpU0tlSXRmMHdZTEFN?=
 =?iso-2022-jp?B?NytIaEN1ZWdocEh6RjN3L2VzRHhsc3AwUUJJOXJLd0dTNFNlbHVTY0Zx?=
 =?iso-2022-jp?B?L3k3ZFpKOWNrMTB6MEVUamp4SWd3VDRYTHR3YUFqQ3lWMWpGRktOaUYv?=
 =?iso-2022-jp?B?ZEtnL2V2eVJBUlFPQW1JTVlXQUF0RU9iNCtpUjlBaHhjeUtqSVhReUoy?=
 =?iso-2022-jp?B?dStXdW1JU2o1VUxzNVJVa3FTVGZSS2RETDVmSjV3OXByK2VvcW95NlF4?=
 =?iso-2022-jp?B?T3FlbnVPNkFnTEVXd3JuVFNpQjRIT2VPNGY3T2dIMjd0UTdFTFJXNWov?=
 =?iso-2022-jp?B?ZkF5TG9QMUxXM0VwYXJzNzQvaVBBVU54OUNnY0VYNHRzOUNpdTY4MWZK?=
 =?iso-2022-jp?B?cFhucUFGd1QxYjFCSG1YR2ZBb0t5Zk1Mc1NkdnZCTHFUcldtTW8ydmtG?=
 =?iso-2022-jp?B?UExveEhPUG1uZVZ3QWNRMXpTN2RhalUrbFFwb2s3UlVrWm1NTU03NGpy?=
 =?iso-2022-jp?B?MlNZa3NRd1d0ZEJROE9iSUwzdDVUR2RndGQvK1ZuYWlSSU5zWm83b01n?=
 =?iso-2022-jp?B?WWFlenBtNDNjTnR2bldVTjkrb2UvU2FkdzMrTjRtbFhzSEt3QmVnNGJY?=
 =?iso-2022-jp?B?OVZqd3FpTkRjY0tCRnlYOERYalltajJjWVF4NDFoWHhBZ2VXL1dUdXp2?=
 =?iso-2022-jp?B?ck4vb0N2S2gzcnc1Q0lGTWovOFZySkpSYWY3QngwbFM3Y0c1M3J1aURt?=
 =?iso-2022-jp?B?SHhPNXdhdGV4S0RMNElSdVJmYWRaNEVtOW1GNXg0TGgvK3hrSlpRQzVY?=
 =?iso-2022-jp?B?V2h1OEN4RkNsRlFBZEZVeTRURlRXTDgzeWtzaFNyY1M3TG4wTmxadnBH?=
 =?iso-2022-jp?B?c25yN2M2c1dGQXYySEh0aTdhc2Zzby8vVTJRanhvc1NqUmFnaVpXaG4y?=
 =?iso-2022-jp?B?dVlTNDZrb0dFUzg5eU5XK1lFemVkWGdRZ1U1cHhQSUZIeDQ3a1h3UXVN?=
 =?iso-2022-jp?B?d0ljbzZUTTR3OEZGQVRpSDF1THBSVUZkc205S3pwZXJZT1ZaTjJEUzJU?=
 =?iso-2022-jp?B?YjJDcnB6cFlPaFFLSW51ZldvaUhQSWlWRkllWEFLblh6ZGsyYmV6eitk?=
 =?iso-2022-jp?B?Yk0rUFJlWGwrTUlGRDkvMnhQdUxkekV0UW5xSVZTM09KMC84bWVPVXhy?=
 =?iso-2022-jp?B?STJ1S1YvelMxbmxFVmxyQnV2QmxIOFF6VVlJYlg3OFZsdFNSZmdwTlNF?=
 =?iso-2022-jp?B?aHBoSFBLQ2Q1OHdJM2FrdGpTQVhiL3hrT2Y5aUpXQ3BLbk9ic2o0eVNu?=
 =?iso-2022-jp?B?SEhZbEhZNklaVWhsaTEySXZtdlhGcCt1aGd1UkhMcCtsRWdkSHRtck5l?=
 =?iso-2022-jp?B?cXJGNDJ3N2VOdlRaUGZIV3djVXZOa1A2d0drSlhWWFoyemFjZlRBMnRN?=
 =?iso-2022-jp?B?M0poQzFuTUhrS1ZzZzRma0ZiL1ZhdGJpb3EzdlYwY05yK21TVThEWmQ5?=
 =?iso-2022-jp?B?UjZJeERJNW5DaHVobHNCSTdHbUhyRkFuSXgrcFNvampUUkpRWUgvNGd5?=
 =?iso-2022-jp?B?bGF4V2dXRW1MU1VPSXUxZkxleUJ0N0lLNXB3OFovMWRsaXhacU5FdlIr?=
 =?iso-2022-jp?B?N3JsNGJibXZmMGYwaTkvSUJNSVMrNUg5YUZrWUphOVdpemcwbUc5Mmp4?=
 =?iso-2022-jp?B?TGNHeVdsemlxaVdCalY3UGlPMVVUWStzMzZGZkdwd1hQcTBmZ1dXYzFp?=
 =?iso-2022-jp?B?czhoZDVkN09oc1hFRFErMG1WVU5iY2tqdzRJQktpK1VMZENXd3ZZdzZ0?=
 =?iso-2022-jp?B?eTRldTdKVjk2NGJMek05Mktub1FVM2ZlYjdVV0NIYUhCaDY0Si91VDk0?=
 =?iso-2022-jp?B?Z212MDJGdjJlRWdWV0hmaXY0NGlaSjJTdWVBTzJ5OGNOMHJrNjZhYUV4?=
 =?iso-2022-jp?B?cWFDZkZwc1hMN2VxbGxCTEhWSzNUUmRCbUR0SVExZ09QN3YzTnpVWTVx?=
 =?iso-2022-jp?B?LzJJUExmcmE3WEF4TEJQUlAzWHdsSEE1R25lRktjT2VYS1l2ZDFGbFRY?=
 =?iso-2022-jp?B?YklmNXMrclQ4S0Q4aXgxcUxKOEUrWm9ScXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c996efc0-28f5-4657-bfe1-08dccebdb062
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 21:48:48.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqv/RF1auDu1FSZsU6jbckKld8wXe326pTFs/L1PRBZdFQcOYoyEv0iN9Co3R5uAz5c3GW1qW7FR5AbYv/s5uLvkgYhsGctXMViKtQXhAsLmCxMUYndUo7SpLPw47bxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Sep 2024 21:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16859

Hi Pavel,

> v5.10.224-rt116-rc1 -- just wait for release, then do corresponding -cip.

v5.10.224-rt116 was released today.=20
I will be releasing a -cip based on v5.10.224 for this.

> v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release myse=
lf?

Thank you for your suggestion.
I will worki on the 6.10.y-cip release at the same time as I work on the 5.=
10.y-cip release.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, September 6, 2024 4:33 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Subject: 6.1.107-cip release
>=20
> Hi!
>=20
> I took a look at -rt releases, and...
>=20
> 4.19 -- no suitable -rt
>=20
> v5.10.224-rt116-rc1 -- just wait for release, then do corresponding -cip.
>=20
> v6.1.107-rt39 -- can I ask for corresponding -cip, or do the release myse=
lf?
>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


