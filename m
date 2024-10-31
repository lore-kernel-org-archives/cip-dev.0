Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D50E68965
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 09:34:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.8536.1730367278007241511
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Oct 2024 02:34:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=An3/+deC;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1730367275;x=1731576875;bh=BC
	2JInFqChMIPni13A1G262VjowIAWprIHfMo7A6wwI=;b=An3/+deCcAXvUe17YuftkJ8/yzod6RXR
	q7rHP30vCPnJwJnYRFdzA4P6Nw44y8cvS14Fj/fhrN4zjVcz2/8IG/cfIGA6OiWjLYLsLi7r0cage
	/ao+EQkuWQEs1W8/PqeFjE1NRXzwxdHHY/bPglytv4tNcknIsAX0gwXpcww3ixNV7Wl0XIk2GX0CQ
	c+i8bNx1n0s4bOf8owrQvZE7pyjSrJLXEvht1lz7QHepoiogYxNtFECogRc7O90GsyU8eJTLy4fyd
	xpuyfjy0Olj5cECYggR4Nnm/BaRyXavqU+nnQ7pD9tfoY6/FIrEqmOejPj4VqJIDgwInJEIv2+Yt0
	PA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 49V9YZcZ2296221; Thu, 31 Oct 2024 18:34:35 +0900
X-Iguazu-Qid: 2rWgGN9FLIOSwsiF4F
X-Iguazu-QSIG: v=2; s=0; t=1730367275; q=2rWgGN9FLIOSwsiF4F; m=O8MEvEaJy1+pyTOU43CY+TnyjfYHts27RZlT6dNNqMo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 49V9YXDf3327054
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 18:34:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVW4YFkwLbFXRiKkqRqx5JG7h4Bw995ZPX3C2cJIKhxYryW5zRND2TNn7ngCtrqJmaZvFolEWMmc3ANHnKZKLei3eHwHpFkO32H0FKvtIOYRdWie7HY4JDYCQlrj/yXCSIErHKEmx7FMvceR23QrmXMGCjHwchsgfD1gb1/Rk4NVWzgygjGREZocpNsfBpmdPjUHLsjuFBIUXNAcOeTpJHCVsMuM02tRhxrcX2Xzyoztmvhwgy9Q7cDeZLHm15KKB+jAFmGmUYG8WLHDNhF+SNRXI0xiaIbiLyEiiXlMn7nXZbNndrYixDlTS5kdkVHkE8KHwAO6T86DXcLNQv0C3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQbiTs6vgGJUKgq71fTIC2gMZXCeGLq9wrp716Gw9Bw=;
 b=iXCub73R6dOCcChSEc5H4QAeCi3Cp/ZHOal1eWHk1o69hmtsI0a55NQe6h+M3fqqHqUiXfkKRX+Vj0Iy+xQHoVo8Q845voBWCxQ6Ji6/VAmf8INXFUMoWvXAdwYkKRKN7u3rX70jHjVH+1nXDVGkNNobv7Sl6ljuxeQWkLfjIOtA0ugHxDbrYv8pDBmiyKAPOcE8bObXK+DllaSJEvHETF3mGt8kj08UnB0ISPprGJmTIySYz5pqaAVnRCWFYm+PWQhClLtgQpUrblPKd0HepERAdr499j+Qa4+M/aalQzcC7IBhMbgmcqcnvHxBP6B2uCBmnKIDI7CD6QQaY38QMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Delay in linux-4.19.y-cip release
Thread-Topic: Delay in linux-4.19.y-cip release
Thread-Index: Adsrdx031lblhZgBQeOAC/KEEGQKXw==
Date: Thu, 31 Oct 2024 09:34:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388D6E1EB10B19539D4CFB692552@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB7098:EE_
x-ms-office365-filtering-correlation-id: e4bb9def-714f-4fe8-2bbd-08dcf98f3992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dUlHOXg0Q1NmYndGb2x0RnRvNW5JL0s0RGJxaUdLSi9KK05vNFg4MnYw?=
 =?iso-2022-jp?B?WjlXaTd2emV1QnpnZVppYy92aithaGFlK3V2cDNlK2ZXanVIZVdtNmlt?=
 =?iso-2022-jp?B?R3BOb1YrYXNnWUxldnUzNkJhNTJ1YXo4eHNlY01raFlqcWp5V1REcXl0?=
 =?iso-2022-jp?B?T2VXbitRUmNyVktpZEp3WFpQb3V5UU9hOGVuNXZEOFY4bllVTUI3UVdZ?=
 =?iso-2022-jp?B?WU9sbDVwWk9lb3dBYmM3cE9PTFlidnlSVFIzRHdxbkcrWHRiVWhTYW1n?=
 =?iso-2022-jp?B?aDkyVVlmVUVpcCs2eS9BZ2RIRmFVMWJEUUpFL2MwaTh5MmxsM1daWUM4?=
 =?iso-2022-jp?B?L3pWTjFrR1kwTTMxZE5jYkY2VlZQd2RNVWZIZVZqd3I1S3JSUG15emRq?=
 =?iso-2022-jp?B?eGJIOHNUZUhyYUcwRzB0WGUyV1FlSHh1Rk1mcmFVN0xYWVpiZUJiZjVV?=
 =?iso-2022-jp?B?OGlKNDBCcDNOem1nTUFTa2ZSZ1F2anExVUliSzUvemZaYzM5cGdVdVMz?=
 =?iso-2022-jp?B?dGFBcG9mV3hXdmY0SG5yVUhodzgzRU16Q3lCYlpZOUF4dER3Y1A0a2Jn?=
 =?iso-2022-jp?B?djQ5Y21pUk8xaGhDaEJ4RVZlMzJoeHlWdVZweXA5WnVHMWZzLzJBNjJH?=
 =?iso-2022-jp?B?WnIzU3grNTJGSS9sSm5vcDZ0YkJibmJxeG05Snp1QTVmajhvZHNGWUxo?=
 =?iso-2022-jp?B?OHlLaUlFQU9HMzEvWSs4ODNldmZzUVN1eXZqc09NWkVmWHlwMG1LL054?=
 =?iso-2022-jp?B?bmpDeDhGb0oxN3JtNFRQWXVjbDlVaWUvMUhNeG9MUWVVNFpjSHE5RGhr?=
 =?iso-2022-jp?B?ZjNWYjdWTDBoQjNCU3JpK2VKNDA2dEZoQ2RMZCtuUEdQZGEvL2V5VEFp?=
 =?iso-2022-jp?B?RHd4dDdKS0pzN2M1OHdrZnFnNlBKTERkZ25Ja3I0cXZIc2hPTzN6RjZx?=
 =?iso-2022-jp?B?alhtblBtU0pLUW9YQnpicGVrREw0YitSRGxBQnRleEVPQ25ZRXJzQzNp?=
 =?iso-2022-jp?B?VzhzTXFQcGVXUjRQR25XMjJZQzljTm1jeVJCWHpaWTY5VXY5WjJOd1Z4?=
 =?iso-2022-jp?B?cnNuRGMwWldxbGRBUkxJTVE3VTNSK0syUmJDUVRSMXg2UkN6dERJaFRD?=
 =?iso-2022-jp?B?TnZvYkRlVDJzR1QzcFNzUHhCT2RVL0RYK2oxZElWZkFNM210ejV0K0RO?=
 =?iso-2022-jp?B?bFEyYXlOUjVwVkxqejFkZnpjOXpNLzBOWjBiY2hnV1dKRW5wUVp2Z1Vn?=
 =?iso-2022-jp?B?N3R4bXhNM3NzYnp3S1lWUTFaQzNKalhLV0hwZnI1ejhHZlAzM0R3NzVF?=
 =?iso-2022-jp?B?UnZmYUdWOURsZmVvZUgrZWZnWXEyeGtPQXd1czhvZnk4R25YNHhZNXFu?=
 =?iso-2022-jp?B?Ny9VdzJaeWxwWjJIdU5DbkJNRmRuMi9qUzh3NnlLQWJwOS9uTzJTMGlF?=
 =?iso-2022-jp?B?a2xWcjhJamNLd1pZZFdHMXdjaGh2Qkl4azVRbWR6dE0ydjcwcGFyaEgx?=
 =?iso-2022-jp?B?L3BKeng3SW1FbFZTRmZSVS9MWjA1bFp4QnlZTTlLQ3MvVVNteFNObGY0?=
 =?iso-2022-jp?B?ODFIVXJFNkhIUVF5MFBzSzJEaHZtU1k4NEJyc3EweXRtMWhVcDg2d1ds?=
 =?iso-2022-jp?B?K0J5SjN3ZVhRL1JGSGtPZUdFTmhLeDZMWS9uU2NGSk9MZjN1eVFpaGNE?=
 =?iso-2022-jp?B?UCtPVG1TNnZqVVBqaFY1aWVXM0ZIc1dzeFFuYUU3dk1HYkNkMXZlVkll?=
 =?iso-2022-jp?B?MlVlc1hmT2RmMDBzZmFGbzZncENnQWhqSVpYSlducjJuaEdTZm9XZE1z?=
 =?iso-2022-jp?B?ZHRiQ1p2ZGpsOW5zcmpoVUZwZWlqdWREZUdsczRaYVMxRWt1M1B1RVpZ?=
 =?iso-2022-jp?B?UTh0T1A4WWJqazBXYkZTTUxqOC8xdUN0T1FiaEZybjA3YjErb0F1TVI3?=
 =?iso-2022-jp?B?ZTdWczN6RXhTU1ZZYlJ3eWpSanhRKy84Sm9RVklsUmxYMlk0bjdEdzk1?=
 =?iso-2022-jp?B?MFMyWExkMFdLZHo0S2hpN3NrQS9VOVcwanhNaUJQWWhnTG1rbFV0cC9X?=
 =?iso-2022-jp?B?RlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NVVVbjd0aGxoemw1ODdnaWx4Z2dobXV2bzROaHBYNUMzNnZHVHBvcitp?=
 =?iso-2022-jp?B?R0VvRWdvbVhTU0NjTDJYdTIxZWU4N24vaXZ5SVBEN0g2VnpzUVpCRWJl?=
 =?iso-2022-jp?B?L0RCQ2NwN1ZMQVlzTVRDcTQ3M1YzLzZZZXdxc3Nab0oyaVlDUWZBUkh2?=
 =?iso-2022-jp?B?UDhWd0Q3NndKVUlkRkIrOEhpYlh3T3MrQW5Dd2tabXZMYUlORzhCUEZq?=
 =?iso-2022-jp?B?RzJzSjV3emY2d0Z6SHZiTXF3VmtaeXJoVGd2U0kvQWdrUkN3ZWtMSmlT?=
 =?iso-2022-jp?B?TkRldE5FZFZVY1F3WGdOZzRSZlZoc1VSK2UxaHlEdHBnV2Z0RHU2eHdP?=
 =?iso-2022-jp?B?dlBhZ0lrSFBrcGN6NGUzblFuUHJRY2RZRGN4RFlZdjZRQVljdWpXamR0?=
 =?iso-2022-jp?B?Q3cxYzZjcmtBeU93a2s4T013aldpTGFKUGhFTG0wcWk2Um1MMVlTN0cz?=
 =?iso-2022-jp?B?enNLR1VyM2FxOVUzMG00cjVxNzR0UlBPOCs5Y2Z1ZnQ3UFhaaVdxcnJR?=
 =?iso-2022-jp?B?Slk4Q2NiQVJqdE1zcURIODdudThaUkQ4UVJYRTlBQzVVUEVHRmtubzN1?=
 =?iso-2022-jp?B?SzdHd0RNVDFDSW43VXQ1V2pCd3c2dnhsSXZCZXAyK3JJS2FhaXRqQTRo?=
 =?iso-2022-jp?B?eS9jaU9hUG04bXhERlFHbU01Vlh1azVJR2s3R21JSDdUMDdGR3JLUVNX?=
 =?iso-2022-jp?B?RWZKVHBYeUZUOGRyUHBJbG9oNzNhTG1JYjlNVW80MHdLVk00cElZd05P?=
 =?iso-2022-jp?B?dmZFVHYzckt2dk5MZHhtRXJFb1lTYjh6RnZYNjhNMGNkRzZwWlVVU3Rt?=
 =?iso-2022-jp?B?SDVvdXdKSWsyTk9MdjJra25POE5XS0VvUUV5M3BJaHp1dElSSWN4UXA3?=
 =?iso-2022-jp?B?cHNKZmlqblcyME1aQTk5NnpyaUpHVDJsbldCSm5HK1FCZXF0UTJvMEFn?=
 =?iso-2022-jp?B?VnpqTWN0SURJY1hDMDloZTV2Rko0MkhqRnA1dHZzcjVNazRrV0VJbXVy?=
 =?iso-2022-jp?B?Wm1PcTU2dUVSYU9TNUZCeFVNSERMbVdmckd0L0xRSHJaWHZaOTJTV0ND?=
 =?iso-2022-jp?B?UXhSWEZWcmJjL2RkTmIvOWZ3WVFxMzF6N3hMVkF6dC9GRXNXQUFzcTUr?=
 =?iso-2022-jp?B?dXkrek5IWnRvSmdkYzMxamRQU2QrQUlkZ1VVdEJ6NFcvRE54N3JPbEpw?=
 =?iso-2022-jp?B?K1dFcnpkVUNIclgzd2xBb3lFZ0dHUHI5WE1pMUJMRldSaURIRVkwSmhw?=
 =?iso-2022-jp?B?UHJHN2JYUDVzMnd2SFJjdm41eXlvVE9VcHpGMlYwZFBpVDMzUHU0MlNG?=
 =?iso-2022-jp?B?Y0xxYVlOQVMwUm1nMTJkT1R3eVhJVjRRR3c5azUwN2dremhVWkVBRzEy?=
 =?iso-2022-jp?B?OVV0KzA1Nkl4T2xPN05XbEY4SFBJRkFpdEJMUFhqSmZjeGlNRy8zRTNm?=
 =?iso-2022-jp?B?VHNtQ3p4aGRmYTZyMjVLeEptTWJPVWRESVhSZGMvSTZXRFhwZGZwVk5Y?=
 =?iso-2022-jp?B?OFJFMmdDM2EzSkFHR3k4ZmU2aEZ3WFNFV0ErcmxyNURLTERVZVBzcXpr?=
 =?iso-2022-jp?B?Y1VwY2RBVldmbnNTWDBRTksxZHB4bEoyL2pTdGtYbkNIa2RSeUtzM210?=
 =?iso-2022-jp?B?UUhxdEVnUTBBZ3hPVVZ2cmRsRU51cEU1bDZRVEt4aVM2OWljRFZDSFdW?=
 =?iso-2022-jp?B?cXV1UDByUHZxUDRuajNvMkxZL2NYZzQ1bS9TT3htREVwenNRc2JWKzUx?=
 =?iso-2022-jp?B?UUswSmRSMXQ2Mi9GUVNUOGdzL2wvVXRXUjhuaXEyVkV2Z2RsMEVPdG0y?=
 =?iso-2022-jp?B?NStNRm9peXNYSzl6KzJoY3NJVzR2aFpoZmsyS1c4VWk1bFRhbFVMNVBQ?=
 =?iso-2022-jp?B?MmNWeCtGbUxrVkNpN3FHKzR0K3Vyakg0WFYxNVlxYTUwcEpOWjl5UDds?=
 =?iso-2022-jp?B?UTFzdU4rWTI2dk5nV3o2TjdzS0taRlZqaG1LS1dZME5hVDFFVzVNbWFO?=
 =?iso-2022-jp?B?cDZSV0VPdVFrdTVuSUFzdFp0RVR5dGw4Ti9DVmM1VjErU01iLzlMbUdQ?=
 =?iso-2022-jp?B?dUsyMVFhMlRMVXVwb1hQOHozNXlSNXdGTk03VmlRb09hazl1ZkdZTmRY?=
 =?iso-2022-jp?B?bkVIeEdIZUVOOEFweStLajN2WjJtZmZqZlJkRmRYQzEwcHVWbWVQcXBL?=
 =?iso-2022-jp?B?Y0dtNmJjSE84OUdoTTBVR292N3pjbXR5a21SVkhzOVpPdGFxV0VpZWU1?=
 =?iso-2022-jp?B?dm9ObmJQM0R5SFFwb3k1NW1OSy9rN0NyVWdlQTJ4Z2F2QW94ZTM3eVZX?=
 =?iso-2022-jp?B?YVJuUlU5dkRkQzZ5R1FHd0xCTndCcXJ6R2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bb9def-714f-4fe8-2bbd-08dcf98f3992
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 09:34:32.0706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwxvgsV0eshSjzRTB/F92gY2mzAyIRz6UxaJYCyks74O3N/TArjC/eLEjA8OdpVglNqVWY6PbRSBq+thG17Gznk+4TYTf/jBPnqiPNkqF+K/x2rSL6S2qQMW+14OYW/l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7098
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Oct 2024 09:34:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17128

Hi all,

A new version of linux-4.19.y-cip is due to be released, but is delayed bec=
ause LTS linux-4.19.y
has not been released. We are going to release linux-4.19.y-cip as soon as =
a new linux-4.19.y is
released. Please wait for the new linux-4.19.y-cip release.

  - latest linux-4.19.y: 4.19.322
  - latest linux-4.19.y-cip: 4.19.322-cip113

Best regards,
  Nobuhiro


