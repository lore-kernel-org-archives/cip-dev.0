Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED2C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 12:08:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.76])
 by mx.groups.io with SMTP id smtpd.web10.15254.1714046903639130321
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:08:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nvWGstch;
 spf=pass (domain: siemens.com, ip: 40.107.22.76, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ4ryurZ5Jo1GP4gZ5H6eC5Ht97eoWhauNlmKj3HIiM+J+DyiLNw5A+5U1o6bk0Bww86kUh9ca+JxhWb3PbU+nZvxP1JRAS584IxGLYno2hteF93+s1eTS2kX94oedKgfUk4eRkJVwsWbUOnqwzzUm1QjhcU7pAwgOHDXefR6yWwDGilcTrsCfMd/SlcE+mWKtO2YkTEgAchuU5mDVYnDd1yAmLjf52OMu6BuqWQOPuVSrGT6ljGI4jQaQ0XiDzUm3ftmxglkTdx7ZEP7+WTEuaQRwJubcP4BOzG4iUE2dBW4oiUgBAaTDcH5HoKXwGldXcIGkh2b9woE3AczK/Twg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI6pjfbtYWM0EDdeWF2eNnKNi3loNkPALbo/MZElzRw=;
 b=iHpxB5E+OjIKwFRNHGuynw2S+itNFbGEEsxepmox3v/icCMk15Y/PBnFgPD10euCYk5sFHkkU+RuxLbDdfQ4uvmGXvhcoYmBi0iLF0X4o/HiJWkIJ5JHOO+PjuTSyGoEdXn8FE1ZHz2aUmBIbHirgl5cS9ykGRPNF2Rz8pNXdNlOON4tGzI++Vx/s2uQNaGyo8SRdaQUDYVDeMdhaZJSKYmrnJ7pHjr2XZBfPKi9QxgZH8dYgicqBZQ7rHCWJsgDmoVfROWdSnUPkUjOqgLTsnSoqcxhTmNE2N2PrBhzeaKwGRQIhFWfYHZlmyBTKiQ6bR3YZLwKcr6DZPcP9OLGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI6pjfbtYWM0EDdeWF2eNnKNi3loNkPALbo/MZElzRw=;
 b=nvWGstch0O6tXRYcqQNtVaVh9svg94nrC3s/w09b25rR7PZIuEo8j/D2qFw6ird0L6oIot/UW3gPRTsfdOx64CRbr+syNxJ8CED24mMBj5I8DkKKaWA9JscP3u32rhuCWc9PmKsMtUgkNugnrJv8zRFp33xJP7DL1jJ5yWCv39nTGDk/2Nd0IqFTDkIfRRDTQz7UJj6bklLDoqHdKA81iWZ/g4tb6p+cdU3uCjWsAWCj3E7BcdBvDHNnKSAL3luIx+4n4LINX/anV2hV7VoKO9o9Y0oYImdskmjJ1WmqgIEu18LiBfOzrCvwVvhgZOARirmjda+lYfU7puDZLVQLZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:08:20 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 12:08:20 +0000
Message-ID: <cf0c0cb3-301f-4421-93ae-8fd7604c80d3@siemens.com>
Date: Thu, 25 Apr 2024 14:08:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/9] fix: use luks2 to identify
 encrypted partition
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "johnxw@amazon.com" <johnxw@amazon.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
 <20240425115119.813384-5-Quirin.Gylstorff@siemens.com>
 <a225004498fa9569d635d96e01d460ae8b9b3695.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 xsDNBGE5tqgBDACpa0M7NVvWkE84XaWEmmQT0REu4Ad8DGRzxlQdLHn4PwakShu46Kl9Rrwm
 KZsIoQaLMM+e39xkl70bNFAKOodEgnkwzywjRkOXzf46AkBs3xThp/SMuZXIgdXDXhJupN1G
 1Zu0GbIx316GZaXf9lXuiAwwqJXKWsjRuFSNopQUMs4R4v7CRuwx/y2CPkAbq9rhph6njcaO
 4JTkkd8s0IA8Ec4otQ+YcUpRvrqHQAx3jFP3hDO93s1Ja8iLkDHxveD/5dnCoJ7wBxWQw1D+
 Qy/YsKzT9eBCo41aiP2sh6Xae7YAF/bZGXm5Nh/tIN6tM9O2ujsvICJMgaQ6KvLl7uLE12Ey
 3Tiatxuse0cRCVLU6dL/ljm7jY30gBpgP6UpMYANNKbjH1QHOkyM0725Wodh3s2kb+nMSgCr
 bx8kbD03tFAOFdmMANUmTI2XUcUUuEPHGWMViZlKi8GEIElXMXJi3WJSJBFaEYj/ns6lGKNk
 zE053GrLzJHh1wcZmPWHsZMAEQEAAc0vR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmluLmd5bHN0
 b3JmZkBzaWVtZW5zLmNvbT7CwQkEEwEIADMWIQTY7GSkZ04ObjDZR5UG7p+HXEQunQUCZNTY
 OgIbAwULCQgHAgYVCAkKCwIFFgIDAQAACgkQBu6fh1xELp2ViQwAkSIZKvKai3o1yAsYQGYZ
 Pa9oIzM1+rqGPdBTqJ8LCIUM3kDz7kNo3nll2mnhtZOAeA/DpEc/pQGpIUUm2XQJEOCCv4Ze
 fO2tFuhACpU6Yz3XwQhr1SHy/KPsxUmiTgZUzfvlDxFzOuvKt4kg7/lC4/qm4i4ZRbohjggS
 XwLAawfULBSzoiTaMi6GtPm8e8oLoBwdo7UIwHHlN5s5UoEruntnc/Tx6+wWquHX/3/zVGUu
 OBqixq3uClkTNCY4itIix9yuMsUgWUgarN2BjcDxeNFIxlozGgcMmWyRobDOPfL7I0YHXm3/
 uB3wg4ei5dBCB12uYKr4CH/S3CRtYXUaIdyFoxYlvpEoUfuHthB2wcqQllVg3IEhGhkuvfTX
 snzeMFhg7wU7HlX/MDK5EnAGK9fHvZMnbb+H78bMNtoisBPY7XwuOAyUOtwMq0SR8G+9ZLnC
 ABeS6tyPB8UePy8MWdcTQRboXubmUkDAIwBuNI2xALMYZxyUZWEzD+M0euWLzsDNBGE5tqkB
 DAC6s08UAYSENgz33zbBZ+XWlo5A7muxzYjwN77DMgC5EcuqQJA2YnMO15mkB2YcTbP2Zf97
 ZhjTneRwe62xurjO2SOwPi0Sw3JN+VBQ1hpxMHJ2KjeAjJeQ4kINYgFFF5vNfgfGi7eI9qrL
 hViCf0Osulj7IGD7vDkib1WoO++SRO+9DShVD4sFIi0Gv9YSTalazpT9bgcAtnaDb/viLvaU
 qtK7S5rvFVPiuUD60yvmr3Pfd5iPKSxIQS/5/uKWGjeCntNu4ujoIg3C5rnDRIp4wcKIYXOu
 Nq0uGT52B4jtakb7jomXGX1/MZAHSRzUNUrup0UbwWCJEuvUEizq3G3Kg/Itvns5JzZAyGHk
 Jn0Sa9sTZCN+lNspvl1/t4F9ogBQbGOWPaslScjUQ5VDul8oLGMK1Zi+mj+SYFpQCXd7fwhP
 fl+yQlOdzGOGKHk9jqcaRHizuXtabQVIGrO8I52p26QJWaVqmMvJRWRqykxzk0Sw17/YDOBQ
 iEE0QOivBwkAEQEAAcLA9gQYAQgAIBYhBNjsZKRnTg5uMNlHlQbun4dcRC6dBQJk1Ng6AhsM
 AAoJEAbun4dcRC6dnnML/jLf8oN9BMkd/UaOtBh04YQQLR8TFwahbIZQZUakRteSaWILgGT6
 vuu19bbSaU3WAFHiB+ftuLYxCh9LB2YjEjoaDeFY+qOpYHsWKrE1g/rr5iEPyb+V3FZvd8a2
 fbSo7Hdw9n0jzAr6Yb6dMnU2FN6iRrIYoreEkEB5WbrFfmEyQGdxF45FGnu7mkLMGs4P8hiC
 Jpn73cdGB7Mj5+XWAcoYKDqXiKm6FL9Bfle7RO6FaI0m5JqQjGmsTLAIDaY6ZYSQmBzY8WzY
 5e4YlveowP9E+boqYhyPLGdDFVGhWwHMb/VkeFXAwsNtsfQfmpb/VmWs0urz8WkvYpiF6pZw
 Xe/DyZ2leVdCQVbhsUb4z1b1nAYAxVB+4yIqi5uc1cQYFzb1LPeMcQ0YVv9UAjqaYzP4vh6e
 2zRoeyL3H2PAQbodkBam6WiNHFG0HezOnSTxOHcpqx8s8bzgrJHGj6eUbQjxG27SGvTcy6Gs
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <a225004498fa9569d635d96e01d460ae8b9b3695.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: e0246165-e2f3-4afc-1493-08dc652065a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m50kDiwh2gmixYH7doSRON64lwYRc+Klbr8dk4F98ZqFcjSmMWEhql48SMPy?=
 =?us-ascii?Q?WyEL4QjcEoXftnX3vAd3Hf1vMc0RPIz8gVFeS9E+7RYmCraSl7qjFQEU7S4s?=
 =?us-ascii?Q?nUzPvCOiLQV6rrk6wWmF7AtqtAtrSgIbU/5H0Njed333+0trIQ0HNmVqBbEH?=
 =?us-ascii?Q?Q8u9k0+MR/7PPNFqOX8gP6EPZ5SW8tSeZ44og9eBj+h+TzaMbTwZ9HsSy8+D?=
 =?us-ascii?Q?NegaaEsu7g2/ED8VMULKccyzDwG4uG/0TpsSRzQAlmoM2GHoKNnUrdujBAN+?=
 =?us-ascii?Q?9QF+Z2eaGIxkfEDTMpugAB54UmAy63P+M/jQFohSZTrvNI5fXFgDhA3Nt+u3?=
 =?us-ascii?Q?lupQvj3Qyyv7vFXGHFHoZoyKgvHvyhISYcdSsleYAHBW4RQEDhCF9iw/ikpf?=
 =?us-ascii?Q?zo9nfGhwir/ndFit2FKlEBUP+hLvHAab9XCxG87WV61lHJrRXBBCByM6+19f?=
 =?us-ascii?Q?wa9Qs53iA3kzNQF8b07bmwTM5qpNGxrGzpfCwKU5T3AJroK1lGNMIfnqwU1f?=
 =?us-ascii?Q?HYLXRu2+iDv9rNVNRBR63y34x3eZFXC87etre7VNek2TafBj0B/n/tNuZOxZ?=
 =?us-ascii?Q?xxahyhd3hjKkEv18WaMrV7VECvB/FpsJS5wq4Dke7dg8X5OQ8d3KOx0SEXmx?=
 =?us-ascii?Q?OAHw8Tg519k5fnv77J7+m2XltXqEGihw/5ZINrqiHIjAsm2NqSnYWgv+Mxkl?=
 =?us-ascii?Q?Yoczo7zGFmU/5Y11xsNRELDWmpv/zMZk/CgDt5WOA3mYuKkPpD1gW/v6x+Tf?=
 =?us-ascii?Q?aHkUpM/Un3PqRjnqniH31uqSiUkVbUgx4F2/WyJ33VvDnn2I+dsD5Wgp6f3T?=
 =?us-ascii?Q?L24Rgl5kY7yAE+SRQnrm2JSkBYGlptuQ+Cv2h5Amk8COoAkEHGG3gwQpdYc9?=
 =?us-ascii?Q?tyeMdNC6eqVW3I34XRo1/4zyCp9qCyV8cL7p9xRlWUHHxWaMKonyZCKECwRw?=
 =?us-ascii?Q?XfNCBTeK81VPSDlFNI7envv961gaQNp91bhzL+NlR3orA4tQvG41ToNGvbCU?=
 =?us-ascii?Q?vFWRFwyC2s9Q6Yzzg/Jer5HgbbXj3Zo9GgzFIjOTod88vhFrh0/aEACweNc2?=
 =?us-ascii?Q?uR7iEAo+UHD/mlaPVtABFKhW/4Wcm8jpVcKkJ5cpWR23Ib6eccmisG9O7SYp?=
 =?us-ascii?Q?cNwVAnbnWVYC1CPb7icTW54XD44nJOT6BmzqGOHecx2rwtadYokOF2IYb8E+?=
 =?us-ascii?Q?7v+da5mNLlP6gB4YOvzvRJOUSdCySzDOefsBsDZyoacNYRRLlX2ChH1N6GDG?=
 =?us-ascii?Q?Zf/hIN6Iml50elZN8PZgFXwex8wYi/jWY3SvLr1UHw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a0Cx5RNWlF5NOm43IXnhOrSMITPDpZ7F3JExJAIlzPd5TQJXpRtrF4F7xG55?=
 =?us-ascii?Q?mPaJPkusegql5cZfqt8TWJz0I79XOsuhylBi4PnH9+krI5rti1BklZZKo2KL?=
 =?us-ascii?Q?5ZVHJoNhovtX46c+lQSU/gnHwcvhZoHWCifNPdZHARG6xs53vIxtOiQCXKHX?=
 =?us-ascii?Q?LQOESnfRTzP14Ip6/zhHnDmqk0Oq3kVDJMUODcAeK843hlOVK2s6R/BG4jgN?=
 =?us-ascii?Q?jiRBHZkai4il/JHIJ1Dbhp5ZWos4OT0I0NemMTNjHm8r/mQyq+0Mk2roXalE?=
 =?us-ascii?Q?xS65f28vpH19YtlE3Hm/YpztBNmtxBT8iHf/fbCxqmeZJAmXyMNMdZ2ccdH3?=
 =?us-ascii?Q?jP7OlkdxvKh13Z9Zf/9gRfq/zLQvPAwmA9ofedpuNofia4eXeQUJg8JLlzEn?=
 =?us-ascii?Q?nLqRRn+2RtsMEc7aQo9VBTVpZZK4Ebcuw3SLI8b9m/1peAV7v/scteCJ/uso?=
 =?us-ascii?Q?XeUF7qgerOwL1xEnT4SPEA+z/DwRAwFluHWyojOc0bcwn13lTs9W9Fa642fQ?=
 =?us-ascii?Q?qq49Xeeu9l0l6pkw8H7uv8KvcEby8Vz56UCotkh4gf4gJUyyAQ3B+1X64Xtl?=
 =?us-ascii?Q?7RaKQwCXBqgPZ0yTQIa59f7FyQnfmDiYA77heT18Fh+FiO2VTIbVbhiOOV6Z?=
 =?us-ascii?Q?WmxfCyA7x1BwBsBWbSKqPS7LbYYWFd6XX390aBcfnjAs5AjlZkH37S+Yk8UV?=
 =?us-ascii?Q?wVEEX+67PStqq9Hukp8gmQpjG+OAZ1XKgjHXclvsTG+YKkLOXP2ms+h6kI7V?=
 =?us-ascii?Q?JuuPZgxgvScWWjWLPXnPRxrz8tiPQB3cg3kVz6gxX89ApIGxmbCccXs7kv/H?=
 =?us-ascii?Q?awGjq+DcIFF5ljOvGQoenjEXNHB74H5FzrB4I6YIm94FtoGVtwCXfFeSdLmO?=
 =?us-ascii?Q?bAxppc2Q8MItOqKfOA5LwzJidii7H3PdKB1ycuvjIcVqSwMvqB7x3yk0IM5W?=
 =?us-ascii?Q?mGumdCA+Du0VQ4+W8277PcJAJgvvGKbIeMJ2xJ0kCnksq4yb1p8zBTFcH6b8?=
 =?us-ascii?Q?nEmpy1ab5UPoqKw8qSk/r1rO2n9NSp4t0z3V5D19heZbjJ0YK4Pinq9O6VVK?=
 =?us-ascii?Q?YR43S3doyhHPnGN4Zy0zZMZeGoG4BjAOsKwaYesPrfFBjjSUC83YyxAGqkKc?=
 =?us-ascii?Q?8MfW1lOsSSJIgnABTMyCEKEzwJlMqWKwCD79Thtn3Jj7Sf+YkztbxMg2EV95?=
 =?us-ascii?Q?U33HShAtHpNbD5gyu7/0weuGG2n6gEgmI7wJoMirqN5Um6XgOEWdDY79QzKJ?=
 =?us-ascii?Q?T9gHwRyjS+WN2cFFfebNEjvnKOBiblp5W+qTiCeox3Lb1Wo6lu1ISby8wNuF?=
 =?us-ascii?Q?nyE2ZzZjWYiwjpQ/nEAni+tCE/tGNtji68OoEh1AczTd7YiDG0CX7faZGRGk?=
 =?us-ascii?Q?Vz3ybFvThUVUNvr4OEV8nJ6QxhbapC20Y98ICLnsT2y7WhEAhfhFrj0hNcY2?=
 =?us-ascii?Q?AhyjGXfVxvzFGFMpEB1W76xzI3EwvMw9vr8o6cqCgrWQ2YwXFnGKkEPRn3w+?=
 =?us-ascii?Q?MmJGgspDNyCvrrl+ikkDlYrl8WaxRPKJ3kMb9TWevQS3+PQweH1KXFKo0KrX?=
 =?us-ascii?Q?62T6kpRj55N1eO5CsAJCvyS5jsAhd5DpinpdhZ1CzYAxV8PCmmGKQHpkpnFM?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0246165-e2f3-4afc-1493-08dc652065a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:08:20.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8nP8PovJ7nrjV6f1/zOxhYylibDEa1UyFsj19Q3mtdGABH+2s8PNSc5B7txxQTm54zhE+Y2kHhCWeFyU7ABjesVC98mZMzPx9BDOZ87Kfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7945
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 12:08:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15761



On 4/25/24 2:06 PM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Thu, 2024-04-25 at 13:50 +0200, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes an issue with encrypted rootfs during system reboot.
>> With the token option it can happen that during reboot the no
>> valid Luks partition is found and the boot up fails in the initrd.
>=20
> This is an interesting testcase for the watchdog. Does the kernel
> already trigger the watchdog at this initrd stage? Did the system hang
> here forever, or did it reboot?

As we have panic=3D5 enabled the watchdog will be triggered and we have a
reboot loop.

Quirin
>=20
> Felix
>=20
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0.../initramfs-crypt-hook/files/encrypt_partition.script=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
>> +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-
>> crypt-hook/files/encrypt_partition.script
>> index 51c81f3..685d882 100644
>> --- a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script
>> +++ b/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script
>> @@ -134,7 +134,7 @@ for partition_set in $partition_sets; do
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if /usr/sbin/cryptsetup=
 luksDump --batch-mode "$partition" \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "token"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "luks2"; then
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0open_tpm2_partition "$part_device"
>> "$crypt_mount_name" "$tpm_device"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0continue
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>=20

