Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4165.1795174558804878410
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 03:35:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MGXDumC1;
 spf=pass (domain: siemens.com, ip: 40.107.162.12, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXB2ffR0ehGlD25lgGKWkcNWNBo0p81GVtCdvAneEeaGVyyo9MSOSTnD0h2hhJ0yOhPWFkvmJjh+cBQ4Zi00y2FrpF+ZKH2/j0IDX7JmC6GsopsK3v4sZkMdfrKxiewUP/v13lV0QKBaziP7wX0AfGUELdIaZcYUXhesRXyvxY4bzEqMmR5MhJxGso/NedRCpwJdZJaDsaKL5dRaODnTbHnYgEjDd5XUJYLR/dNIBvSOHQQB5gIVzjlEPjxUtDteHTPEB0Xsdk3rFIaJzDiskg0GwyVKT5Pa82T8use270yM3D2o8jxDYl/G/Kw63ny2nshDq13FnNf2lZGNhDeYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBSGzaxtp4UZSORvTg/B3v98LuudxcMZFxdmGkWOz3A=;
 b=At8DoB4eR0BGHg0jmDgutLFQnWVhfB2n0blaE55rKqb8yJS318UTTvpJwJZ0FzUfVK9vNAtfwRjnV5XgX0Tp2mh/OegDPwejvieMb2gnpgEIwSMnxeqjlsNG0SsrTOYVNDTqcXEPOLY6tb2LaFzY9irRCoKPZK7AeNds9toiRubHQKE8KhHAPyHi0wZg9/vdheFajyhgikG4xSnhhprJREbROj/6+ge8xt8a8VITPE6+pC+eB23snHpri4lIwJ+0gXAl4DAmDb7UVPYPJeQRoowzNq8xl92W1co9/JfdrKBHQbk0HEnX8aTO3zh+/Dp/mbTG7KEADYOixAb3ksaHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBSGzaxtp4UZSORvTg/B3v98LuudxcMZFxdmGkWOz3A=;
 b=MGXDumC1o8rdUBaOvvOAolhNiwmksfdl6SqNOzKOnSzDUKD7/kYDstQG9edQgosYsEEZ3lVFQvrDS4XGqzsdwlpdhYsRVV3brWzUwPYLv6oksSUdIgEUwCpCLwxZeLQd3FlI3lYi4VM/DJd4fsWqqsTyCa3JpDnc0sv47fG3mEee2dat/s3Yusn1HcjhUlXasWBkovaDujdyD7CcvAOXwoG1Bw78s+fJk5V+uTvtKWrIpD31Dp68sbEOfa5KFI6x1QhezETV76btL+hWON27vrkndjsKgp5nIqCiYsSQYzlRJO/QaLkLfHz0D/ITL6qXyN8t7Ip+DVe/G1I4EgI5SQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV1PR10MB6684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 11:35:52 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 11:35:52 +0000
Message-ID: <efd9acba-edc4-4f64-84b7-16d00a696a54@siemens.com>
Date: Fri, 20 Nov 2026 12:35:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC PATCH 4/8] scripts: add Python LAVA
 job generator
To: "Moessbauer, Felix (FT RPD CPC OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan (FT RPD CPC)" <jan.kiszka@siemens.com>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
 <20261120082554.375548-5-quirin.gylstorff@siemens.com>
 <8c28f5b017fb03a155adb8f2c799f75b9d986ed6.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 xsFNBGhxJPIBEADH6a6idt3FEJo4DFxeRRX2ZUHJjOSPTpBN4vK2FbvDJjBVLs1/xzNpOE/N
 CxDcH0nd4BApJeGzxjJpsHW9gm9w80oIG2HAZl4es79JdRt6H5GTdFaux1J8tLVTCS3bzeuu
 ydAUTesliWxSiEb4vqpmcduI42edmJF9E43jjLXDyJcXJa0qYXA0qvChJr7gbkGmWc7iR8A5
 ZX1CrJJbwUBtzXGGThDPycgPYB1eR9OcFWJ2E6dBcLQiNxyOvxfpTKf09eZi2hBrZESpjMKo
 U/t9LX9SbyRwzpIeXQe8LQgyhppENmGSjc+Lm0YIreIU4ODbt1takxHTIpin1Po7lFiDMQmW
 aZrfNFKNQoffVyHq1gpV5BGIbnm8yJixpEueL2oygnN/evyNPQV7NzSoQaJy2lJRGjo4YrQy
 dfpJyaajNeO1njSttdWC30q28ZUorPzBPfLwt7B/BXyiMiY6/SZunfKQDAY+g835YTjEhBgl
 KtXEamOfypEvYfvzQUpLrFgK55yrDSndtNm71APD4oVNeV1I0KqbuBQk4o3TkR6ZYb4RLp9O
 dKGEnKCBaBaWJgf/1v4BLJ/ge8k135R1JLiyK/FylJbnsABE9k7/lELFKrwW22qgspkQAf13
 h2+T65+637hkxhGRYnrtmxjOUk4EbYbAA+rtj0mpBxnziWojQQARAQABzS9RdWlyaW4gR3ls
 c3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPsLBkQQTAQoAOwIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgBYhBBvkezJSXuvL6yeVgtxQXbgz0zl1BQJocSb5AhkBAAoJ
 ENxQXbgz0zl1vv8QAMVze9Jevd0Qe9iYY64RX1rQfGv0xI094u9+4fOsIOXUjX70cbRgOZzk
 muPuEj96pBh77vGWb19dyWmzlRL0tTGg4ACcbHXgy93l6HaUTlVLUFpEKx1ufo2StSPPZ1i9
 4PBTfnyAhQqYH6dibaFpCHvhrNvLIidA/C3qBx2b5k7H9k/Hta/lhNPkJTSqLnUl2sU36ihb
 QFGvEOUnJjFVo7eUBDNjEDGXETfI2tfHuER7GxZZINFpzf1mnvgobaai0pt26XUrt0cdONGR
 slIv6hEQ4BcyuYEN5wZz68eMMQtaTXRoCGYPYpTEYu23BKYTPebIUAbM+CiEVHTkH2TSeDwM
 kc25z0ydFbA2D8I8J+atdBsmHlGCq1gMnSMZ/TtOrlL6OHFoVlaq95Z55a5cq72DF1BQBk1t
 jaPgiI3Frzn/ZLFfldakTbkd2vsZjBJEkcUtnc+Rm7x1Sn3X855zJmvYRzdLAPMsi/zVMsy6
 tvoIcJozan1CQE/vC1S5V8BXoE0PRointtfTxPDuX2//sSzlRgBVWIQJHuQ0asb+gzptVZT+
 naNdi+fexKfoSv6bxbsG2Bg7Pm3OZNASmaUodGNixZ3/y/VdzvvSaPPULYPuUCdZrTtX4wML
 ae1/UjUw7jUoEXOalGior+tSEUpvhfa9y8kzJswmtZW90lFYNuCtzsFNBGhxJPIBEACi38/X
 QWBviWYBLlk2czd15VQFpsfYFKzgO010e300DAL1D+CWatD7yiEK30m3vvHkOkyHaOz/DB18
 ksr1czcbQLYSpdC4JKlsUu75tf9EI32QBPRMms7mJ+qewti4xj1sjrBpuczzLC0CG+dkxTD2
 38AbgGW3m/o8zBsPGhVnJlRVGsYU/YiYxaE6MC/l5bzmb0ay58ySnSS32zALKBfXGpWmk1td
 KbcHNeEBuZu2W3ZYB5cTkDEE/3ycnWwqWh5u24SSLC/83rIeAjeyJ/wQ9+oSIHLlcl296sqM
 1wYKVCjwAXfA7vcEBsANUFL6NkdP+Y+HJPRT/EODKZsjqWjoi/5v5GKBLrScLxA9cpjTCYMj
 +1slg6T9FgUMQ+7GtbGI+/3WA/8ZE8emq4EweLzYT7I6hLB/dnoqRZFmRkLZ8q81r3Oc+xIc
 PJEnEpQIN/Ky0YelyPY4j+GH+NOlLvv9pH16I46O5PsTCkyhcfgfYUOJgP1BRQrnRmVn6586
 R86jfLLhtaagvg4Mb4NtR+ZAO8rF8xmrEv5q0YZBkRmMlRENwHWiCyvDzU7mTsyYvVweGgdL
 bak4VTz/Bm2kvnJyHAWOhWJk6BAgmQhM1c0eYG/vmyhS6O+omYIyDJFVp0ui71CazCFn7dDI
 +uzg6o6fHygmWDn43e4mu3WKEXCajwARAQABwsF8BBgBCgAmFiEEG+R7MlJe68vrJ5WC3FBd
 uDPTOXUFAmhxJPICGwwFCQPCZwAACgkQ3FBduDPTOXXrfw//Rc/CskZYHeM06zTK0NQKTt3+
 hgME6rUQh9y4iDF1KjEvmVDGyDma8AQ45WNP5EbWgMFWGtlTYwn3CbFuYlDLMtCYHkth1itN
 SoUdOttJkQ5ULq8DW+MFrP4xlG0zAx+CWeug6VhujVBro9xK57zgYs+LsCK3nlsYR91ZtZ8E
 73Bi58iGZL/DLRFws5ut9hGUE0HoxXAhUZ6de0QxXNmfApzK+rLUye+JYcEVWEfVCCofFy8X
 lk+r2OzCvMt43xu9OgV1Pg37ez4HVu+ZoPJ94NKteQr9QMR9PIOBXGlOuweKiR1IcYBjQHzL
 aptU47KTf+lJxZhy8H3l1ySuyQqxbFoPNUuAT9Fu2s7Mg7QzjLVkoIrkZ+YJ+CmgvZT4sPZe
 YAMMbi+ENwLUg7aYqCy1RHcit2jeoEMyJJ9PFcsbxcqIPaCG3xOurgMdwlGeGdaxSFvq1T4V
 Z50bOHQvqT4TbOxbxv8RLLtaNfIvudV3J+Xx3QyKY1sySFcCtCB/b4zoKqc73B5B0nXBw931
 qIxmFqiZiwfFB91OCCqRFtm2LcfwR1fLrUtSrhmENjdBhZljfJKjxAfFOWXngfT10Sin9h20
 4A7NrVMzatAJLl79L0PdJIVpGUDQHU9K7rIs2MoQKzmAvyUSJB4sAChft5wz7JbvFKqY2fW4
 Z2NBPBZUysw=
In-Reply-To: <8c28f5b017fb03a155adb8f2c799f75b9d986ed6.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV1PR10MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c728417-921b-4590-624e-08df46fa6e57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|29003799003|9063799003|25016099003|12006099003|10136099003|55112099003|20052099010|3023799007|11063799006|56012099006|5023799004|4143699003|261026140227099003|261028144727099003|261026121527099003|261026135527099003|261022113327099003|261026130827099003|261022115727099003|261021135927099003|261022105027099003|261021130227099003|261021123027099003|261009223027099003|261021121427099003|261022075727099003|261009221227099003|261021133027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: XzGi5kreXX0SD2V7R6ojhpE8qcQIGaUlvleTghJ3008/H4/a2WVSvpY9YZm41oF8IPIVu6vK1k59hJ0LqASeqOsz+oNTVpIpDoxqgNnbSCLtMqjeEZaL+39V0PaMt39HJxIZjCMqS6PkukzYOJHVbxzVgDAIVMuk41dzOHeC0EFXrM/HjQotg/qVHIg4EY4mgw8EV2VxiZUJDVWY2HkX+P67tv2hjOltk5KVisdgIwcK0ZSt4e6P8ib9EI1cXOELkUMoAPT9jIU0NOkXcxFtiVLA8/mSjJA6JT1kpWN1VobejTVAl7sZHcnxmdvlNtzF7lzPk/WhVH8tDEvp7NGq/yJ1TJjavHgzCqAtk90/aUT0ZYthMdh5nCJVNKYIzRz+pKwOe2wPyaPwyQUacrSbKv2tllpMW/Km5y9hh2kHg2YsLBbK1Oaln/ypGTJ5MNGNmnSg68xKNjY5J+pV68EHWmiDHcG+JXIoEx2K7O5KhCApeEcy24GaW2G8txgchwvsYEOy0LQxxE7kVqtBupSAjFPbd/FG6mUqI2fbI8ggQL6nNt428o73EuRA0l2kYTemYHG/w4k+bRGmr9ZST+UuH7j9pJ5Id2sC0G9/Ax/xzV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(29003799003)(9063799003)(25016099003)(12006099003)(10136099003)(55112099003)(20052099010)(3023799007)(11063799006)(56012099006)(5023799004)(4143699003)(261026140227099003)(261028144727099003)(261026121527099003)(261026135527099003)(261022113327099003)(261026130827099003)(261022115727099003)(261021135927099003)(261022105027099003)(261021130227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022075727099003)(261009221227099003)(261021133027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t136Scqxdjd+47DipIkKIFMQa44CpPcbAe0wN31ZPrPCSyOENGAJ90aZzmiu?=
 =?us-ascii?Q?lABqgy2cii4D/ieWVbZWZ7Cd1VgKFFo2lbYZEK0WaI1K4RRnCj5pGOkrqu5U?=
 =?us-ascii?Q?2aYBqxTwBLXtjBHzhqh6PblqlyG2pTtLkB6NIk7aJdpedsV64ou+fbL+KlzJ?=
 =?us-ascii?Q?9ABo8jN4dK5N17saQu9Eek/6axRtPXl/b2/c7EtHPlKXDsxwvV6eaowojxA0?=
 =?us-ascii?Q?cGpQ1tzCRSQikh64heAZXh6N5n/rFZe1t9fc6YiYO22EKWB9twgyzjO/7+3U?=
 =?us-ascii?Q?N18hoxbSeT/FyuKHMidE+gCL6s8a8GGKFZ0QxPtFyjT1SQzxfYq4M/APenGW?=
 =?us-ascii?Q?322XjnnTzKeLeeQ5Qtu6DvHomgw3Ach/9a8nyQ11rwGH14UV9zwCl0bETUPR?=
 =?us-ascii?Q?IWMy7RrobVeOgs8efasbxuHT4+l9Y4RjbnuGquGEGokcZke/MUrgZAaueGNP?=
 =?us-ascii?Q?5GGLgG6F6E+VRXaF5929s6Sh8D8FptZ262X1GGuK2Nu/OSYVQpO1FZBZvBfR?=
 =?us-ascii?Q?XN20u36AvNZ6Owqi9R9JeiAQeVJU4YRRmrQpiSnZM1hqPGJDfBUn9hH4N5ax?=
 =?us-ascii?Q?ikPQZypZirVk4MSu4DH0Keg0kR0ytmgertmuos0dCJaZU3gPGK7oScqrWLoC?=
 =?us-ascii?Q?3UmihgUeTUhYYmtbHsP///HznO6CLc4TXIjdyYUFUOLjqLXgwTdsma/tL/Di?=
 =?us-ascii?Q?EnWwt0djMClfEQDNNOmhkHn0MAaEUIXsWd71hhGT2mH6K1AzwhkYaqSfQrii?=
 =?us-ascii?Q?myG/2mWUBf2uHdvqbHGGGAxpJqgxqg/Zbb7qFZqULFb519NBxracUMt0i46z?=
 =?us-ascii?Q?xXCVH4aQrpCX5Vj+yg9575QUp7N6pRzIbLixLfz/IKxx1APA+Fc2W8+XLzMC?=
 =?us-ascii?Q?FhGmA370ZKCgMGieAzSqgs/qBGGEOx+/fZAcV/jyx3YTI3HsoZz4atC6BaLQ?=
 =?us-ascii?Q?UjLcqQtCJgscyGGflYA4RaF01EmwO06xBmhTqgqY1RvlZbAZzJEr+kZbugS5?=
 =?us-ascii?Q?GmG60M5i9sp9YkX+e2rLHFCap9lAxZlZvzU4EKI+L+s0wD508tvmCGHlPh7q?=
 =?us-ascii?Q?7WtPI/neHcdnrBdhzfVAhE7hCha1dwiTClQjZxv3R+lek43fVkXysTWOFIlP?=
 =?us-ascii?Q?Cekfv+ZgCiRk4ppgnR2zkvABPcrag5hVPtltw4MIr41cYkefdvgex3h83WFc?=
 =?us-ascii?Q?9YX/4U/ocTUQXs+ym/TdRcz+39gJr3IULf/lssgcuZo6PwxXRfflTAfBZ9qi?=
 =?us-ascii?Q?1qKbC1naiWV07O5hTBu4PV9D+XP+hKawSohPug6g+KZRK3Mx6I1qyyzUS9PA?=
 =?us-ascii?Q?TQ9qLthPRB23rFHJxNQIrgQouJOPqc+/DIIa8T61f7AeOP9kej8cZSzBOY3f?=
 =?us-ascii?Q?DcwJ/MAXWF75JiT+7IGEex+HIEr7a9Y15rmEiysgvot0vAJXb2UmG5O2lGZR?=
 =?us-ascii?Q?FsO0KAALxMMeAocZxK07nRFMLq9NJKuEj2SHmCxbn3gVeNzf+K8amhb4vEvZ?=
 =?us-ascii?Q?Zq3eG8Fr2GWVFGTofV54jBNc3fEKiIPhLl1C/VplEGltPHwlm/UNhQ21w1QF?=
 =?us-ascii?Q?kHbb7D6KRotKo6r2y48pbuiEJSFAA1dsPguPZ4UWAQaINvJNVutmVuddZhWN?=
 =?us-ascii?Q?xez8dVx08gDy0C21quZ4wuVgqOfJaccGAeBYs3/oWudnzN1HdKLPxfJ8UlQS?=
 =?us-ascii?Q?tkRIZulrYCZ4SJXwF9+TzSwUtpqLfaVA04A9rZ/6pZIOhkmUwxxjOQLZn85v?=
 =?us-ascii?Q?EbQKzKDndZDv+bGfp6IpHDvKc6YRelM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c728417-921b-4590-624e-08df46fa6e57
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:35:52.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U2ylDUN8My1/FBXODPojYGxsEuCL0S6I3i+59D3Zqc1jqiD038Qwc1WA0z314cOF9r2FzbqEbTtYiyJrBCV5ER7Z2Yw4T7xkmA6e/gcwXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6684
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 11:36:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25040



On 11/20/26 11:48 AM, Moessbauer, Felix (FT RPD CPC OES-DE) wrote:
> On Fri, 2026-11-20 at 09:25 +0100, Quirin Gylstorff via cip-dev wrote:
>> LAVA job definitions were built from templates with unquoted #name#
>> placeholders (not valid YAML), so only sed, grep -A and cat could edit
>> them. Edits could produce broken YAML that was only detected by LAVA,
>> and shared parts were duplicated across the templates.
>>
>> Split the templates into valid-YAML fragments (tests/templates/blocks
>> and steps) with ${name} placeholders, describe the tests declaratively
>> in tests/templates/jobs.yml and compose the jobs in scripts/lava_jobs.py
>> with PyYAML, the parser LAVA uses. Each rule is a small function that
>> makes one change. Per-job text edits run before the branch and release
>> are filled in, so branch names such as fix-sda-x stay untouched.
>>
>> The old templates are still used by submit_lava.sh until the
>> commit "scripts: use Python LAVA job generator in submit_lava.sh". Unit
>> tests are in tests/test_lava_*.py (python3 -m unittest discover -s tests=
).
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0scripts/lava_jobs.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 371 ++++++++++++++++++
>>  =C2=A0tests/lava_test_helpers.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 37 ++
>>  =C2=A0tests/templates/README.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 109 +++++
>>  =C2=A0tests/templates/blocks/action_tpm.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +
>>  =C2=A0tests/templates/blocks/boot_after_update.yml=C2=A0 |=C2=A0 24 ++
>>  =C2=A0tests/templates/blocks/boot_mcom.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 28 ++
>>  =C2=A0.../blocks/boot_mcom_after_update.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 ++
>>  =C2=A0.../templates/blocks/boot_mcom_secureboot.yml |=C2=A0 30 ++
>>  =C2=A0tests/templates/blocks/boot_qemu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 ++
>>  =C2=A0tests/templates/blocks/boot_qemu_noprompt.yml |=C2=A0 15 +
>>  =C2=A0.../templates/blocks/boot_qemu_secureboot.yml |=C2=A0 25 ++
>>  =C2=A0tests/templates/blocks/context_qemu.yml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 13 +
>>  =C2=A0.../blocks/deploy_downloads_postprocess.yml=C2=A0=C2=A0 |=C2=A0 2=
2 ++
>>  =C2=A0tests/templates/blocks/deploy_mcom.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 17 +
>>  =C2=A0tests/templates/blocks/deploy_mcom_swu.yml=C2=A0=C2=A0=C2=A0 |=C2=
=A0 18 +
>>  =C2=A0tests/templates/blocks/deploy_swu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
>>  =C2=A0tests/templates/blocks/deploy_tmpfs.yml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 22 ++
>>  =C2=A0.../blocks/deploy_tmpfs_downloaded.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 21 +
>>  =C2=A0tests/templates/blocks/header_mcom.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 29 ++
>>  =C2=A0tests/templates/blocks/header_qemu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 31 ++
>>  =C2=A0tests/templates/blocks/monitor.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +
>>  =C2=A0tests/templates/blocks/test_iec.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
>>  =C2=A0.../templates/blocks/test_swupdate_apply.yml=C2=A0 |=C2=A0 26 ++
>>  =C2=A0.../blocks/test_swupdate_check_ustate.yml=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 26 ++
>>  =C2=A0.../templates/blocks/test_swupdate_inline.yml |=C2=A0 26 ++
>>  =C2=A0tests/templates/blocks/test_swupdate_mcom.yml |=C2=A0 27 ++
>>  =C2=A0tests/templates/blocks/tpm_restart.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 21 +
>>  =C2=A0tests/templates/jobs.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 193 +++++++++
>>  =C2=A0tests/templates/steps/corrupt_rootfs.yml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 16 +
>>  =C2=A0tests/templates/steps/corrupt_swu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +
>>  =C2=A0.../templates/steps/corrupt_swu_artifact.yml=C2=A0 |=C2=A0 18 +
>>  =C2=A0.../steps/reboot_without_confirm.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 +++
>>  =C2=A0tests/templates/steps/same_uuid.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
>>  =C2=A0tests/templates/steps/unsigned_bootloader.yml |=C2=A0 16 +
>>  =C2=A0tests/templates/steps/unsigned_kernel.yml=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 16 +
>>  =C2=A0tests/test_lava_branch_names.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 +++
>>  =C2=A0tests/test_lava_cli.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 87 ++++
>>  =C2=A0tests/test_lava_core.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 61 +++
>>  =C2=A0tests/test_lava_fragments.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
73 ++++
>>  =C2=A0tests/test_lava_mcom_jobs.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 107 ++=
+++
>>  =C2=A0tests/test_lava_qemu_jobs.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 112 ++=
++++
>>  =C2=A041 files changed, 1889 insertions(+)
>>  =C2=A0create mode 100644 scripts/lava_jobs.py
>>  =C2=A0create mode 100644 tests/lava_test_helpers.py
>>  =C2=A0create mode 100644 tests/templates/README.md
>>  =C2=A0create mode 100644 tests/templates/blocks/action_tpm.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_after_update.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_mcom.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_mcom_after_update.=
yml
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_mcom_secureboot.ym=
l
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_qemu.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_qemu_noprompt.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/boot_qemu_secureboot.ym=
l
>>  =C2=A0create mode 100644 tests/templates/blocks/context_qemu.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/deploy_downloads_postpr=
ocess.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/deploy_mcom.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/deploy_mcom_swu.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/deploy_swu.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/deploy_tmpfs.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/deploy_tmpfs_downloaded=
.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/header_mcom.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/header_qemu.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/monitor.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/test_iec.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/test_swupdate_apply.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/test_swupdate_check_ust=
ate.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/test_swupdate_inline.ym=
l
>>  =C2=A0create mode 100644 tests/templates/blocks/test_swupdate_mcom.yml
>>  =C2=A0create mode 100644 tests/templates/blocks/tpm_restart.yml
>>  =C2=A0create mode 100644 tests/templates/jobs.yml
>>  =C2=A0create mode 100644 tests/templates/steps/corrupt_rootfs.yml
>>  =C2=A0create mode 100644 tests/templates/steps/corrupt_swu.yml
>>  =C2=A0create mode 100644 tests/templates/steps/corrupt_swu_artifact.yml
>>  =C2=A0create mode 100644 tests/templates/steps/reboot_without_confirm.y=
ml
>>  =C2=A0create mode 100644 tests/templates/steps/same_uuid.yml
>>  =C2=A0create mode 100644 tests/templates/steps/unsigned_bootloader.yml
>>  =C2=A0create mode 100644 tests/templates/steps/unsigned_kernel.yml
>>  =C2=A0create mode 100644 tests/test_lava_branch_names.py
>>  =C2=A0create mode 100644 tests/test_lava_cli.py
>>  =C2=A0create mode 100644 tests/test_lava_core.py
>>  =C2=A0create mode 100644 tests/test_lava_fragments.py
>>  =C2=A0create mode 100644 tests/test_lava_mcom_jobs.py
>>  =C2=A0create mode 100644 tests/test_lava_qemu_jobs.py
>>
>> diff --git a/scripts/lava_jobs.py b/scripts/lava_jobs.py
>> new file mode 100644
>> index 00000000..c84f22bd
>> --- /dev/null
>> +++ b/scripts/lava_jobs.py
>> @@ -0,0 +1,371 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Generate LAVA job definitions from YAML fragments."""
>> +
>> +import argparse
>> +import functools
>> +import re
>> +import sys
>> +from pathlib import Path
>> +from typing import Any, Mapping
>> +
>> +import yaml
>> +
>> +TEMPLATES_DIR =3D Path(__file__).resolve().parent.parent / "tests" / "t=
emplates"
>> +JOBS_FILE =3D TEMPLATES_DIR / "jobs.yml"
>> +PROJECT_URL =3D "https://s3.eu-central-1.amazonaws.com/download2.cip-pr=
oject.org/cip-core"
>=20
> Hard coded project URL? Why not use an env var?

That was a copy from the original script=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts=
/submit_lava.sh?ref_type=3Dheads#L17

>=20
>> +
>> +KNOWN_VARIABLES =3D (
>> +=C2=A0=C2=A0=C2=A0 "branch",
>> +=C2=A0=C2=A0=C2=A0 "distribution",
>> +=C2=A0=C2=A0=C2=A0 "project_url",
>> +=C2=A0=C2=A0=C2=A0 "architecture",
>> +=C2=A0=C2=A0=C2=A0 "imageargs",
>> +=C2=A0=C2=A0=C2=A0 "context_architecture",
>> +=C2=A0=C2=A0=C2=A0 "test_function",
>> +=C2=A0=C2=A0=C2=A0 "updatestate",
>> +=C2=A0=C2=A0=C2=A0 "job_title",
>> +=C2=A0=C2=A0=C2=A0 "start_monitor",
>> +=C2=A0=C2=A0=C2=A0 "end_monitor",
>> +=C2=A0=C2=A0=C2=A0 "artifact",
>> +=C2=A0=C2=A0=C2=A0 "IEC_TEST_TIMEOUT_MINUTES",
>> +)
>> +
>> +IMAGE_ARGS =3D {
>> +=C2=A0=C2=A0=C2=A0 "qemu-amd64": (
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-cpu Haswell,-pcid,-x2apic,=
-tsc-deadline,-hle,-invpcid,-rtm -machine q35,accel=3Dtcg -smp 4 -global IC=
H9-LPC.noreboot=3Doff -device ide-hd,drive=3Ddisk -drive if=3Dpflash,format=
=3Draw,unit=3D0,readonly=3Don,file=3D/root/keys/${release}-ovmf/OVMF_CODE_4=
M.secboot.fd -device virtio-net-pci,netdev=3Dnet -drive if=3Dpflash,format=
=3Draw,file=3D/root/keys/${release}-ovmf/OVMF_VARS_4M.snakeoil.fd=C2=A0 -gl=
obal ICH9-LPC.disable_s3=3D1 -global isa-fdc.driveA=3D -device tpm-tis,tpmd=
ev=3Dtpm0"
>> +=C2=A0=C2=A0=C2=A0 ),
>=20
> The ${release} is risky. If this ever gets converted to an fstring, it
> will break as release is empty.
>=20
> Also why not pass the arguments as a list instead of this space-
> separated string.

Copy paste :-D
>=20
>> +=C2=A0=C2=A0=C2=A0 "qemu-arm64": (
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-cpu cortex-a57 -machine vi=
rt -smp 4 -device virtio-serial-device -device virtconsole,chardev=3Dcon -c=
hardev vc,id=3Dcon -device virtio-blk-device,drive=3Ddisk -device virtio-ne=
t-device,netdev=3Dnet -device tpm-tis-device,tpmdev=3Dtpm0"
>> +=C2=A0=C2=A0=C2=A0 ),
>> +=C2=A0=C2=A0=C2=A0 "qemu-arm": (
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-cpu cortex-a15 -machine vi=
rt -smp 2 -device virtio-serial-device -device virtconsole,chardev=3Dcon -c=
hardev vc,id=3Dcon -device virtio-blk-device,drive=3Ddisk -device virtio-ne=
t-device,netdev=3Dnet -device tpm-tis-device,tpmdev=3Dtpm0"
>> +=C2=A0=C2=A0=C2=A0 ),
>> +}
>> +
>> +QEMU_TARGETS =3D tuple(IMAGE_ARGS)
>> +MCOM_TARGETS =3D ("x86-uefi",)
>> +TARGETS =3D QEMU_TARGETS + MCOM_TARGETS
>> +FIRMWARE_TARGETS =3D ("qemu-arm64", "qemu-arm")
>> +
>> +PLACEHOLDER =3D re.compile(r"\$\{([A-Za-z_]+)\}")
>> +
>> +# Filled only after all text rewrites (sda -> vda, .swu -> -broken.swu,=
 ...)
>> +# so that these rewrites can never change a branch or release name.
>> +DEFERRED_VARIABLES =3D ("distribution", "branch")
>> +
>> +# Wide enough that PyYAML never folds a line (long shell commands).
>> +NO_LINE_WRAP =3D 10**6
>=20
> What's the problem with line-folding? If the result is parsed with a
> yaml parser, this does not matter.
>=20
>> +
>> +
>> +def load_yaml(path: Path) -> Any:
>> +=C2=A0=C2=A0=C2=A0 """Parse a YAML file."""
>> +=C2=A0=C2=A0=C2=A0 return yaml.safe_load(Path(path).read_text())
>> +
>> +
>> +def find_unreplaced(text: str) -> list[str]:
>> +=C2=A0=C2=A0=C2=A0 """Return known variable names still present as ${na=
me}."""
>> +=C2=A0=C2=A0=C2=A0 names =3D PLACEHOLDER.findall(text)
>> +=C2=A0=C2=A0=C2=A0 return [name for name in names if name in KNOWN_VARI=
ABLES]
>> +
>> +
>> +def substitute(text: str, variables: Mapping[str, str]) -> str:
>> +=C2=A0=C2=A0=C2=A0 """Replace ${name} from variables; KeyError if a kno=
wn name is missing.
>> +
>> +=C2=A0=C2=A0=C2=A0 Other ${name} forms (shell variables), $name and $$ =
stay untouched.
>> +=C2=A0=C2=A0=C2=A0 """
>> +
>> +=C2=A0=C2=A0=C2=A0 def value(match: re.Match) -> str:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D match.group(1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if name in variables:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn str(variables[name])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if name in KNOWN_VARIABLES:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rais=
e KeyError(name)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return match.group(0)
>> +
>> +=C2=A0=C2=A0=C2=A0 return PLACEHOLDER.sub(value, text)
>=20
> Can't we use a proper templating engine (like jinja) instead of this?
> If we keep this, why not use <<variable>> instead of ${variable} to
> make it fstring safe?
>=20
> To me the whole approach looks overly complicated and fragile.
>=20

I will check it -  the goal was that it looks like to current test=20
pipeline.

Quirin

> Felix
>=20
>> +
>> +
>> +def fragment_path(name: str) -> Path:
>> +=C2=A0=C2=A0=C2=A0 """Locate a fragment in blocks/ or steps/."""
>> +=C2=A0=C2=A0=C2=A0 for subdir in ("blocks", "steps"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D TEMPLATES_DIR / sub=
dir / f"{name}.yml"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if path.exists():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn path
>> +=C2=A0=C2=A0=C2=A0 raise FileNotFoundError(name)
>> +
>> +
>> +def load_fragment(name: str, variables: Mapping[str, str]) -> Any:
>> +=C2=A0=C2=A0=C2=A0 """Substitute variables into a fragment's text, then=
 parse it."""
>> +=C2=A0=C2=A0=C2=A0 text =3D fragment_path(name).read_text()
>> +=C2=A0=C2=A0=C2=A0 return yaml.safe_load(substitute(text, variables))
>> +
>> +
>> +def image_args(target: str, release: str) -> str:
>> +=C2=A0=C2=A0=C2=A0 """Return the QEMU arguments of a target, using OVMF=
 keys of release."""
>> +=C2=A0=C2=A0=C2=A0 return substitute(IMAGE_ARGS.get(target, ""), {"rele=
ase": release})
>> +
>> +
>> +def build_variables(
>> +=C2=A0=C2=A0=C2=A0 target: str, release: str, branch: str, iec_timeout:=
 str
>> +) -> dict[str, str]:
>> +=C2=A0=C2=A0=C2=A0 """Return the globally known substitution values."""
>> +=C2=A0=C2=A0=C2=A0 imageargs =3D image_args(target, release)
>> +=C2=A0=C2=A0=C2=A0 return {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "branch": branch,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "distribution": release,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "project_url": PROJECT_URL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "architecture": target,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "context_architecture": targ=
et.split("-")[1],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "imageargs": imageargs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "IEC_TEST_TIMEOUT_MINUTES": =
iec_timeout,
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +
>> +def add_firmware(deploy_block: dict, variables: Mapping[str, str]) -> N=
one:
>> +=C2=A0=C2=A0=C2=A0 """Add the firmware image to a deploy block."""
>> +=C2=A0=C2=A0=C2=A0 base =3D f"{variables['project_url']}/{variables['br=
anch']}"
>> +=C2=A0=C2=A0=C2=A0 url =3D f"{base}/{variables['architecture']}/firmwar=
e.bin"
>> +=C2=A0=C2=A0=C2=A0 firmware =3D {"image_arg": "-bios {firmware}", "url"=
: url}
>> +=C2=A0=C2=A0=C2=A0 deploy_block["images"]["firmware"] =3D firmware
>> +
>> +
>> +def write_job(job: dict, path: Path) -> None:
>> +=C2=A0=C2=A0=C2=A0 """Write a job definition as YAML."""
>> +=C2=A0=C2=A0=C2=A0 text =3D yaml.safe_dump(job, sort_keys=3DFalse, defa=
ult_flow_style=3DFalse, width=3DNO_LINE_WRAP)
>> +=C2=A0=C2=A0=C2=A0 Path(path).write_text(text)
>> +
>> +
>> +@functools.cache
>> +def load_jobs() -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Return the per-test job descriptions from jobs.ym=
l (read once, do not mutate)."""
>> +=C2=A0=C2=A0=C2=A0 return load_yaml(JOBS_FILE)["tests"]
>> +
>> +
>> +def job_spec(test: str) -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Return the description of one test; ValueError if=
 unknown."""
>> +=C2=A0=C2=A0=C2=A0 jobs =3D load_jobs()
>> +=C2=A0=C2=A0=C2=A0 if test not in jobs:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ValueError(f"unknown t=
est: {test}")
>> +=C2=A0=C2=A0=C2=A0 return jobs[test]
>> +
>> +
>> +def is_supported(test: str, target: str) -> bool:
>> +=C2=A0=C2=A0=C2=A0 """Tell whether a job exists for this test and targe=
t."""
>> +=C2=A0=C2=A0=C2=A0 targets =3D job_spec(test).get("targets", QEMU_TARGE=
TS)
>> +=C2=A0=C2=A0=C2=A0 return target in targets
>> +
>> +
>> +def output_filename(test: str, target: str) -> str:
>> +=C2=A0=C2=A0=C2=A0 """Return the job file name for a test and target.""=
"
>> +=C2=A0=C2=A0=C2=A0 return job_spec(test)["output_name"].format(test=3Dt=
est, target=3Dtarget)
>> +
>> +
>> +def replace_in_strings(node: Any, old: str, new: str, count: int =3D -1=
) -> Any:
>> +=C2=A0=C2=A0=C2=A0 """Replace old with new in every string of a parsed =
structure, in place."""
>> +=C2=A0=C2=A0=C2=A0 if isinstance(node, dict):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for key in node:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
[key] =3D replace_in_strings(node[key], old, new, count)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return node
>> +=C2=A0=C2=A0=C2=A0 if isinstance(node, list):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for index, item in enumerate=
(node):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node=
[index] =3D replace_in_strings(item, old, new, count)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return node
>> +=C2=A0=C2=A0=C2=A0 if isinstance(node, str):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return node.replace(old, new=
, count)
>> +=C2=A0=C2=A0=C2=A0 return node
>> +
>> +
>> +def other_release(release: str) -> str:
>> +=C2=A0=C2=A0=C2=A0 """Return the release whose OVMF keys do not match."=
""
>> +=C2=A0=C2=A0=C2=A0 if release =3D=3D "trixie":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "bookworm"
>> +=C2=A0=C2=A0=C2=A0 return "trixie"
>> +
>> +
>> +def find_empty_steps(node: Any) -> list | None:
>> +=C2=A0=C2=A0=C2=A0 """Return the first empty `steps` list in a parsed s=
tructure."""
>> +=C2=A0=C2=A0=C2=A0 if isinstance(node, dict):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if node.get("steps") =3D=3D =
[]:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn node["steps"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 children =3D list(node.value=
s())
>> +=C2=A0=C2=A0=C2=A0 elif isinstance(node, list):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 children =3D node
>> +=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return None
>> +=C2=A0=C2=A0=C2=A0 for child in children:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found =3D find_empty_steps(c=
hild)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if found is not None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn found
>> +=C2=A0=C2=A0=C2=A0 return None
>> +
>> +
>> +def tmpfs_deploy(job: dict) -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Return the deploy action that boots the image fro=
m tmpfs."""
>> +=C2=A0=C2=A0=C2=A0 for action in job["actions"]:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy =3D action.get("deplo=
y")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if deploy and deploy.get("to=
") =3D=3D "tmpfs":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn deploy
>> +=C2=A0=C2=A0=C2=A0 raise ValueError("job has no tmpfs deploy")
>> +
>> +
>> +def assemble(blocks: list, variables: Mapping[str, str]) -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Merge mapping fragments into the job, append list=
 fragments to actions."""
>> +=C2=A0=C2=A0=C2=A0 job: dict =3D {}
>> +=C2=A0=C2=A0=C2=A0 actions: list =3D []
>> +=C2=A0=C2=A0=C2=A0 context =3D None
>> +=C2=A0=C2=A0=C2=A0 for name in blocks:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fragment =3D load_fragment(n=
ame, variables)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if isinstance(fragment, list=
):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acti=
ons.extend(fragment)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif list(fragment) =3D=3D [=
"context"]:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Fr=
agment holding only "context": deferred so it ends up last in
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # th=
e job, as in the old templates.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
ext =3D fragment["context"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job.=
update(fragment)
>> +=C2=A0=C2=A0=C2=A0 job["actions"] =3D actions
>> +=C2=A0=C2=A0=C2=A0 if context is not None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job["context"] =3D context
>> +=C2=A0=C2=A0=C2=A0 return job
>> +
>> +
>> +def arch_spec(spec: dict, target: str) -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Return the per-target part of a test description.=
"""
>> +=C2=A0=C2=A0=C2=A0 return spec.get("per_arch", {}).get(target, {})
>> +
>> +
>> +def job_blocks(spec: dict, target: str) -> list:
>> +=C2=A0=C2=A0=C2=A0 """Return the fragments of the job; per-target block=
s win (M-COM)."""
>> +=C2=A0=C2=A0=C2=A0 return arch_spec(spec, target).get("blocks", spec["b=
locks"])
>> +
>> +
>> +def job_variables(spec: dict, target: str, variables: Mapping[str, str]=
) -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Combine global variables with per-test and per-ta=
rget values."""
>> +=C2=A0=C2=A0=C2=A0 arch =3D arch_spec(spec, target)
>> +=C2=A0=C2=A0=C2=A0 merged =3D dict(variables)
>> +=C2=A0=C2=A0=C2=A0 merged["updatestate"] =3D "2"
>> +=C2=A0=C2=A0=C2=A0 merged.update(spec.get("values", {}))
>> +=C2=A0=C2=A0=C2=A0 merged.update(arch.get("values", {}))
>> +=C2=A0=C2=A0=C2=A0 if spec.get("swap_ovmf"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Mismatch keys test: boot w=
ith OVMF keys of the other release.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release =3D other_release(va=
riables["distribution"])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 merged["imageargs"] =3D imag=
e_args(target, release)
>> +=C2=A0=C2=A0=C2=A0 return merged
>> +
>> +
>> +def defer(variables: Mapping[str, str]) -> dict:
>> +=C2=A0=C2=A0=C2=A0 """Return variables whose deferred names map to thei=
r own placeholder."""
>> +=C2=A0=C2=A0=C2=A0 kept =3D dict(variables)
>> +=C2=A0=C2=A0=C2=A0 for name in DEFERRED_VARIABLES:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kept[name] =3D "${" + name +=
 "}"
>> +=C2=A0=C2=A0=C2=A0 return kept
>> +
>> +
>> +def fill_deferred(job: dict, variables: Mapping[str, str]) -> None:
>> +=C2=A0=C2=A0=C2=A0 """Replace the deferred placeholders in every string=
 of the job."""
>> +=C2=A0=C2=A0=C2=A0 for name in DEFERRED_VARIABLES:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replace_in_strings(job, "${"=
 + name + "}", variables[name])
>> +
>> +
>> +def add_steps(job: dict, spec: dict, variables: Mapping[str, str]) -> N=
one:
>> +=C2=A0=C2=A0=C2=A0 """Insert the test's steps into the job's empty step=
s list."""
>> +=C2=A0=C2=A0=C2=A0 steps_spec =3D spec.get("steps")
>> +=C2=A0=C2=A0=C2=A0 if not steps_spec:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>> +=C2=A0=C2=A0=C2=A0 if "fragment" in steps_spec:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps =3D load_fragment(step=
s_spec["fragment"], variables)
>> +=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps =3D list(steps_spec["i=
nline"])
>> +=C2=A0=C2=A0=C2=A0 find_empty_steps(job).extend(steps)
>> +
>> +
>> +def rewrite_texts(job: dict, spec: dict, arch: dict) -> None:
>> +=C2=A0=C2=A0=C2=A0 """Apply the test and architecture text edits to the=
 job, in place."""
>> +=C2=A0=C2=A0=C2=A0 # Text rewrites, in the order of the old submit_lava=
.sh. They run while
>> +=C2=A0=C2=A0=C2=A0 # branch and distribution are still placeholders (DE=
FERRED_VARIABLES):
>> +=C2=A0=C2=A0=C2=A0 # 1. test texts (kernel-panic, initramfs-crash) matc=
h the original
>> +=C2=A0=C2=A0=C2=A0 #=C2=A0=C2=A0=C2=A0 fragment text, so they run first=
.
>> +=C2=A0=C2=A0=C2=A0 #=C2=A0=C2=A0=C2=A0 Per-target texts (M-COM overlay =
name) follow.
>> +=C2=A0=C2=A0=C2=A0 for old, new in spec.get("replace", []) + arch.get("=
replace", []):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replace_in_strings(job, old,=
 new)
>> +=C2=A0=C2=A0=C2=A0 # 2. '-broken.swu' update image: first '.swu' of eac=
h string only.
>> +=C2=A0=C2=A0=C2=A0 if spec.get("broken_swu"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replace_in_strings(job, ".sw=
u", "-broken.swu", 1)
>> +=C2=A0=C2=A0=C2=A0 # 3. guest disk name (vda on arm); after 1 so '/dev/=
sda5' inserted by
>> +=C2=A0=C2=A0=C2=A0 #=C2=A0=C2=A0=C2=A0 initramfs-crash (amd64 only) is =
never renamed.
>> +=C2=A0=C2=A0=C2=A0 if "disk" in arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replace_in_strings(job, "sda=
", arch["disk"])
>> +=C2=A0=C2=A0=C2=A0 # 4. EFI boot loader name (bootaa64.efi, bootarm.efi=
).
>> +=C2=A0=C2=A0=C2=A0 if "efi_name" in arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replace_in_strings(job, "boo=
tx64.efi", arch["efi_name"])
>> +
>> +
>> +def build_job(test: str, target: str, variables: Mapping[str, str]) -> =
dict:
>> +=C2=A0=C2=A0=C2=A0 """Build the LAVA job definition for a test and targ=
et."""
>> +=C2=A0=C2=A0=C2=A0 spec =3D job_spec(test)
>> +=C2=A0=C2=A0=C2=A0 if not is_supported(test, target):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ValueError(f"unsupport=
ed combination: {test} on {target}")
>> +=C2=A0=C2=A0=C2=A0 arch =3D arch_spec(spec, target)
>> +=C2=A0=C2=A0=C2=A0 values =3D job_variables(spec, target, variables)
>> +=C2=A0=C2=A0=C2=A0 early_values =3D defer(values)
>> +=C2=A0=C2=A0=C2=A0 job =3D assemble(job_blocks(spec, target), early_val=
ues)
>> +=C2=A0=C2=A0=C2=A0 add_steps(job, spec, early_values)
>> +=C2=A0=C2=A0=C2=A0 rewrite_texts(job, spec, arch)
>> +=C2=A0=C2=A0=C2=A0 fill_deferred(job, values)
>> +=C2=A0=C2=A0=C2=A0 # Firmware (qemu-arm64, qemu-arm; never M-COM) is ad=
ded last, after all
>> +=C2=A0=C2=A0=C2=A0 # rewrites, since its URL holds the branch name.
>> +=C2=A0=C2=A0=C2=A0 if target in FIRMWARE_TARGETS:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add_firmware(tmpfs_deploy(jo=
b), values)
>> +=C2=A0=C2=A0=C2=A0 return job
>> +
>> +
>> +def parse_args(argv: list[str] | None) -> argparse.Namespace:
>> +=C2=A0=C2=A0=C2=A0 parser =3D argparse.ArgumentParser(description=3D__d=
oc__)
>> +=C2=A0=C2=A0=C2=A0 parser.add_argument("--test", required=3DTrue)
>> +=C2=A0=C2=A0=C2=A0 parser.add_argument("--target", required=3DTrue)
>> +=C2=A0=C2=A0=C2=A0 parser.add_argument("--release", required=3DTrue)
>> +=C2=A0=C2=A0=C2=A0 parser.add_argument("--branch", required=3DTrue)
>> +=C2=A0=C2=A0=C2=A0 parser.add_argument("--iec-timeout", required=3DTrue=
)
>> +=C2=A0=C2=A0=C2=A0 parser.add_argument("--out", required=3DTrue, type=
=3DPath)
>> +=C2=A0=C2=A0=C2=A0 return parser.parse_args(argv)
>> +
>> +
>> +def main(argv: list[str] | None =3D None) -> int:
>> +=C2=A0=C2=A0=C2=A0 """Write the job definition for --test/--target into=
 --out."""
>> +=C2=A0=C2=A0=C2=A0 args =3D parse_args(argv)
>> +=C2=A0=C2=A0=C2=A0 if args.target not in TARGETS:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(f"error: unsupported t=
arget: {args.target}", file=3Dsys.stderr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0 if args.test =3D=3D "IEC" and not args.iec_timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("error: --iec-timeout =
must not be empty for IEC", file=3Dsys.stderr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0 variables =3D build_variables(args.target, args.rele=
ase, args.branch, args.iec_timeout)
>> +=C2=A0=C2=A0=C2=A0 try:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not is_supported(args.tes=
t, args.target):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
t(f"no {args.test} job for {args.target}, nothing written")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D build_job(args.test,=
 args.target, variables)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D output_filename(arg=
s.test, args.target)
>> +=C2=A0=C2=A0=C2=A0 except ValueError as error:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(f"error: {error}", fil=
e=3Dsys.stderr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0 except KeyError as error:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(f"error: missing value=
 for placeholder {error}", file=3Dsys.stderr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0 args.out.mkdir(parents=3DTrue, exist_ok=3DTrue)
>> +=C2=A0=C2=A0=C2=A0 path =3D args.out / name
>> +=C2=A0=C2=A0=C2=A0 write_job(job, path)
>> +=C2=A0=C2=A0=C2=A0 print(path)
>> +=C2=A0=C2=A0=C2=A0 return 0
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 sys.exit(main())
>> diff --git a/tests/lava_test_helpers.py b/tests/lava_test_helpers.py
>> new file mode 100644
>> index 00000000..ac0dd199
>> --- /dev/null
>> +++ b/tests/lava_test_helpers.py
>> @@ -0,0 +1,37 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Shared setup and helpers for the LAVA job generator tests."""
>> +
>> +import pathlib
>> +import sys
>> +
>> +TEMPLATES =3D pathlib.Path(__file__).parent / "templates"
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent.parent /=
 "scripts"))
>> +
>> +import lava_jobs=C2=A0 # noqa: E402
>> +
>> +
>> +def variables(target, release=3D"trixie"):
>> +=C2=A0=C2=A0=C2=A0 return lava_jobs.build_variables(target, release, "b=
r", "30")
>> +
>> +
>> +def build(test, target, release=3D"trixie"):
>> +=C2=A0=C2=A0=C2=A0 return lava_jobs.build_job(test, target, variables(t=
arget, release))
>> +
>> +
>> +def all_strings(node):
>> +=C2=A0=C2=A0=C2=A0 if isinstance(node, dict):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for value in node.values():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yiel=
d from all_strings(value)
>> +=C2=A0=C2=A0=C2=A0 elif isinstance(node, list):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for value in node:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yiel=
d from all_strings(value)
>> +=C2=A0=C2=A0=C2=A0 elif isinstance(node, str):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yield node
>> diff --git a/tests/templates/README.md b/tests/templates/README.md
>> new file mode 100644
>> index 00000000..decb7a9b
>> --- /dev/null
>> +++ b/tests/templates/README.md
>> @@ -0,0 +1,109 @@
>> +# LAVA job templates
>> +
>> +`scripts/lava_jobs.py` builds LAVA job definitions from the files in th=
is
>> +directory. Every file is valid YAML, so it can be loaded and checked on=
 its
>> +own.
>> +
>> +```
>> +blocks/=C2=A0=C2=A0=C2=A0 one part of a job: header, deploy, boot or te=
st action
>> +steps/=C2=A0=C2=A0=C2=A0=C2=A0 list of shell commands run on the target=
 by a test action
>> +jobs.yml=C2=A0=C2=A0 which blocks and steps make up each test, plus per=
-target values
>> +```
>> +
>> +Values that change per job are written as `${name}`, for example
>> +`${distribution}` or `${architecture}`. The available names are listed =
in
>> +`doc/README.lava-testing.md`. Shell variables such as `$LAVA_JOB_ID` or
>> +`${file}` are not placeholders and stay untouched.
>> +
>> +## Example: a new negative software update test
>> +
>> +The test applies an update whose `sw-description` is removed and expect=
s
>> +swupdate to refuse it.
>> +
>> +1. Add the shell commands as `steps/missing_sw_description.yml`. Each e=
ntry is
>> +=C2=A0=C2=A0 one command; `${distribution}` and `${architecture}` are f=
illed in:
>> +
>> +=C2=A0=C2=A0 ```yaml
>> +=C2=A0=C2=A0 - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAV=
A_JOB_ID/downloads/common/cip-core-image-security-cip-core-${distribution}-=
${architecture}.swu --output /root/update.swu
>> +=C2=A0=C2=A0 - mkdir -p /root/swu
>> +=C2=A0=C2=A0 - cpio -ivd --directory=3D/root/swu < /root/update.swu
>> +=C2=A0=C2=A0 - rm /root/swu/sw-description
>> +=C2=A0=C2=A0 - swupdate -l 5 -i /root/update.swu > /root/swupdate.txt
>> +=C2=A0=C2=A0 - if grep -q "sw-description" /root/swupdate.txt; then ech=
o "verification successful"; else lava-test-raise "Fail job"; fi
>> +=C2=A0=C2=A0 ```
>> +
>> +2. Add the test to `jobs.yml`. It reuses the blocks of the other negati=
ve
>> +=C2=A0=C2=A0 software update tests and only names the new steps:
>> +
>> +=C2=A0=C2=A0 ```yaml
>> +=C2=A0=C2=A0 swupdate-missing-sw-description:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 output_name: "{test}_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0=C2=A0 blocks: *swupdate_negative_blocks
>> +=C2=A0=C2=A0=C2=A0=C2=A0 steps: {fragment: missing_sw_description}
>> +=C2=A0=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: software update testing
>> +=C2=A0=C2=A0 ```
>> +
>> +=C2=A0=C2=A0 `output_name` is the file name; `{test}` and `{target}` ar=
e filled in.
>> +=C2=A0=C2=A0 The `test_swupdate_inline` block contains an empty `steps:=
 []` list; the
>> +=C2=A0=C2=A0 generator fills it with the commands from the fragment.
>> +
>> +3. Generate and check the job:
>> +
>> +=C2=A0=C2=A0 ```
>> +=C2=A0=C2=A0 python3 scripts/lava_jobs.py --test swupdate-missing-sw-de=
scription \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --target qemu-amd64 --release trix=
ie --branch master \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --iec-timeout 30 --out /tmp/jobs
>> +=C2=A0=C2=A0 lavacli -i <identity> jobs validate /tmp/jobs/swupdate-mis=
sing-sw-description_qemu-amd64.yml
>> +=C2=A0=C2=A0 ```
>> +
>> +4. Add a unit test (in `tests/test_lava_qemu_jobs.py` for QEMU jobs,
>> +=C2=A0=C2=A0 `tests/test_lava_mcom_jobs.py` for MCOM jobs), and a `test=
_function` entry
>> +=C2=A0=C2=A0 in `.gitlab-ci.yml` to run the test in the pipeline.
>> +
>> +## Adding a new block
>> +
>> +Create `blocks/<name>.yml` with the action as a list item, for example =
a
>> +test action:
>> +
>> +```yaml
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 5
>> +=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0 - repository:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-Tes=
t Test Definition 1.0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-tes=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "ch=
eck the kernel version"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - un=
ame -r | grep -q ${context_architecture}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-4
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>> +```
>> +
>> +Then list `<name>` in the `blocks:` of a test in `jobs.yml`. Blocks are
>> +added to `actions` in the listed order. A block that is a mapping (for
>> +example `header_qemu` or `context_qemu`) becomes top-level keys of the =
job
>> +instead. The `jobs.yml` header describes all keys, including `per_arch`=
 for
>> +target specific blocks, values and text replacements.
>> +
>> +The `boot_mcom`, `boot_mcom_secureboot` and `boot_mcom_after_update`
>> +blocks are near-copies; keep them in sync.
>> +
>> +## Run the tests
>> +
>> +```
>> +python3 -m unittest discover -s tests
>> +```
>> +
>> +The tests are split by area: `tests/test_lava_fragments.py` (fragments =
and
>> +placeholders), `test_lava_core.py` (variables, firmware, job writing),
>> +`test_lava_qemu_jobs.py`, `test_lava_mcom_jobs.py`, `test_lava_branch_n=
ames.py`
>> +and `test_lava_cli.py`. A single area runs with e.g.
>> +
>> +```
>> +python3 -m unittest tests.test_lava_qemu_jobs
>> +```
>> diff --git a/tests/templates/blocks/action_tpm.yml b/tests/templates/blo=
cks/action_tpm.yml
>> new file mode 100644
>> index 00000000..004ee005
>> --- /dev/null
>> +++ b/tests/templates/blocks/action_tpm.yml
>> @@ -0,0 +1,14 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# ACTION BLOCK
>> +- command:
>> +=C2=A0=C2=A0=C2=A0 name: start_tpm
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 20
>> diff --git a/tests/templates/blocks/boot_after_update.yml b/tests/templa=
tes/blocks/boot_after_update.yml
>> new file mode 100644
>> index 00000000..b7ace1fb
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_after_update.yml
>> @@ -0,0 +1,24 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 5
>> +=C2=A0=C2=A0=C2=A0 method: qemu
>> +=C2=A0=C2=A0=C2=A0 media: tmpfs
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> +=C2=A0=C2=A0=C2=A0 parameters:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel-start-message: "kernel: C:B=
OOT1:linux.efi"
>> diff --git a/tests/templates/blocks/boot_mcom.yml b/tests/templates/bloc=
ks/boot_mcom.yml
>> new file mode 100644
>> index 00000000..d5105424
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_mcom.yml
>> @@ -0,0 +1,28 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# BOOT BLOCK
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 method: minimal
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 45
>> +=C2=A0=C2=A0=C2=A0 reset: true
>> +=C2=A0=C2=A0=C2=A0 failure_retry: 1
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> +=C2=A0=C2=A0=C2=A0 transfer_overlay:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer_method: http
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 download_command: "curl -H 'Connection: =
close' -v --trace-time --output overlay-1.1.1.4.tar.gz"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpack_command: rm -rf /home/lava; mkdir=
 /home/lava; tar -C /home/lava/ -xf
>> diff --git a/tests/templates/blocks/boot_mcom_after_update.yml b/tests/t=
emplates/blocks/boot_mcom_after_update.yml
>> new file mode 100644
>> index 00000000..c6bf047d
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_mcom_after_update.yml
>> @@ -0,0 +1,24 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# BOOT BLOCK (after update, no overlay transfer)
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 method: minimal
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 45
>> +=C2=A0=C2=A0=C2=A0 reset: true
>> +=C2=A0=C2=A0=C2=A0 failure_retry: 1
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> diff --git a/tests/templates/blocks/boot_mcom_secureboot.yml b/tests/tem=
plates/blocks/boot_mcom_secureboot.yml
>> new file mode 100644
>> index 00000000..b26bfb86
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_mcom_secureboot.yml
>> @@ -0,0 +1,30 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# BOOT BLOCK (secure boot positive test)
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 method: minimal
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 45
>> +=C2=A0=C2=A0=C2=A0 reset: true
>> +=C2=A0=C2=A0=C2=A0 failure_retry: 1
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> +=C2=A0=C2=A0=C2=A0 transfer_overlay:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer_method: http
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 download_command: "curl -H 'Connection: =
close' -v --trace-time --output overlay-1.1.1.4.tar.gz"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpack_command: rm -rf /home/lava; mkdir=
 /home/lava; tar -C /home/lava/ -xf
>> +=C2=A0=C2=A0=C2=A0 parameters:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel-start-message: "EFI stub: UEFI Se=
cure Boot is enabled."
>> diff --git a/tests/templates/blocks/boot_qemu.yml b/tests/templates/bloc=
ks/boot_qemu.yml
>> new file mode 100644
>> index 00000000..dc92cbfe
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_qemu.yml
>> @@ -0,0 +1,23 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# BOOT BLOCK
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 25
>> +=C2=A0=C2=A0=C2=A0 method: qemu
>> +=C2=A0=C2=A0=C2=A0 media: tmpfs
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> diff --git a/tests/templates/blocks/boot_qemu_noprompt.yml b/tests/templ=
ates/blocks/boot_qemu_noprompt.yml
>> new file mode 100644
>> index 00000000..90c2bffa
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_qemu_noprompt.yml
>> @@ -0,0 +1,15 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# BOOT BLOCK (negative tests, no login; the monitor test follows)
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 25
>> +=C2=A0=C2=A0=C2=A0 method: qemu
>> +=C2=A0=C2=A0=C2=A0 media: tmpfs
>> diff --git a/tests/templates/blocks/boot_qemu_secureboot.yml b/tests/tem=
plates/blocks/boot_qemu_secureboot.yml
>> new file mode 100644
>> index 00000000..f0abce15
>> --- /dev/null
>> +++ b/tests/templates/blocks/boot_qemu_secureboot.yml
>> @@ -0,0 +1,25 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# BOOT BLOCK (secure boot positive test)
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 25
>> +=C2=A0=C2=A0=C2=A0 method: qemu
>> +=C2=A0=C2=A0=C2=A0 media: tmpfs
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> +=C2=A0=C2=A0=C2=A0 parameters:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel-start-message: "EFI stub: UEFI Se=
cure Boot is enabled."
>> diff --git a/tests/templates/blocks/context_qemu.yml b/tests/templates/b=
locks/context_qemu.yml
>> new file mode 100644
>> index 00000000..caae9f82
>> --- /dev/null
>> +++ b/tests/templates/blocks/context_qemu.yml
>> @@ -0,0 +1,13 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +context:
>> +=C2=A0 arch: ${context_architecture}
>> +=C2=A0 guestfs_interface: virtio
>> +=C2=A0 lava_test_results_dir: '/home/lava-%s'
>> diff --git a/tests/templates/blocks/deploy_downloads_postprocess.yml b/t=
ests/templates/blocks/deploy_downloads_postprocess.yml
>> new file mode 100644
>> index 00000000..29eee1a1
>> --- /dev/null
>> +++ b/tests/templates/blocks/deploy_downloads_postprocess.yml
>> @@ -0,0 +1,22 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# DEPLOY BLOCK (download and modify image); steps are inserted by code
>> +- deploy:
>> +=C2=A0=C2=A0=C2=A0 to: downloads
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 30
>> +=C2=A0=C2=A0=C2=A0 images:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url: ${project_url}/${branch=
}/${architecture}/cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.wic.zst
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compression: zstd
>> +=C2=A0=C2=A0=C2=A0 postprocess:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 docker:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image: debian:bookworm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps: []
>> diff --git a/tests/templates/blocks/deploy_mcom.yml b/tests/templates/bl=
ocks/deploy_mcom.yml
>> new file mode 100644
>> index 00000000..9979c5e6
>> --- /dev/null
>> +++ b/tests/templates/blocks/deploy_mcom.yml
>> @@ -0,0 +1,17 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# DEPLOY BLOCK
>> +- deploy:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 60
>> +=C2=A0=C2=A0=C2=A0 to: flasher
>> +=C2=A0=C2=A0=C2=A0 images:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url: ${project_url}/${branch=
}/x86-uefi/cip-core-image-security-cip-core-${distribution}-x86-uefi.wic.zs=
t
>> diff --git a/tests/templates/blocks/deploy_mcom_swu.yml b/tests/template=
s/blocks/deploy_mcom_swu.yml
>> new file mode 100644
>> index 00000000..2b445fc8
>> --- /dev/null
>> +++ b/tests/templates/blocks/deploy_mcom_swu.yml
>> @@ -0,0 +1,18 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# DEPLOY BLOCK (.swu to downloads, before the flasher deploy)
>> +# swupdate -d does not work on M-COM, so the .swu file is deployed to d=
ownloads
>> +- deploy:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 60
>> +=C2=A0=C2=A0=C2=A0 to: downloads
>> +=C2=A0=C2=A0=C2=A0 images:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url: ${project_url}/${branch=
}/x86-uefi/cip-core-image-security-cip-core-${distribution}-x86-uefi.swu
>> diff --git a/tests/templates/blocks/deploy_swu.yml b/tests/templates/blo=
cks/deploy_swu.yml
>> new file mode 100644
>> index 00000000..7cc5721c
>> --- /dev/null
>> +++ b/tests/templates/blocks/deploy_swu.yml
>> @@ -0,0 +1,16 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- deploy:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 10
>> +=C2=A0=C2=A0=C2=A0 to: downloads
>> +=C2=A0=C2=A0=C2=A0 images:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url: ${project_url}/${branch=
}/${architecture}/cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.swu
>> diff --git a/tests/templates/blocks/deploy_tmpfs.yml b/tests/templates/b=
locks/deploy_tmpfs.yml
>> new file mode 100644
>> index 00000000..2728b609
>> --- /dev/null
>> +++ b/tests/templates/blocks/deploy_tmpfs.yml
>> @@ -0,0 +1,22 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# DEPLOY BLOCK
>> +# images.firmware (qemu-arm64, qemu-arm) is added by scripts/lava_jobs.=
py
>> +- deploy:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 30
>> +=C2=A0=C2=A0=C2=A0 to: tmpfs
>> +=C2=A0=C2=A0=C2=A0 images:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_arg: '-drive file=3D{s=
ystem},discard=3Dunmap,if=3Dnone,id=3Ddisk,format=3Draw -m 1G -serial mon:s=
tdio
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -nographic -netdev user,id=3D=
net,hostfwd=3Dtcp:127.0.0.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/t=
mp/qemu-swtpm.sock
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -tpmdev emulator,id=3Dtpm0,ch=
ardev=3Dchrtpm ${imageargs}'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url: ${project_url}/${branch=
}/${architecture}/cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.wic.zst
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compression: zstd
>> diff --git a/tests/templates/blocks/deploy_tmpfs_downloaded.yml b/tests/=
templates/blocks/deploy_tmpfs_downloaded.yml
>> new file mode 100644
>> index 00000000..2fdd2349
>> --- /dev/null
>> +++ b/tests/templates/blocks/deploy_tmpfs_downloaded.yml
>> @@ -0,0 +1,21 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# DEPLOY BLOCK (use image modified by downloads postprocess)
>> +# Firmware keys are inserted by code
>> +- deploy:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 30
>> +=C2=A0=C2=A0=C2=A0 to: tmpfs
>> +=C2=A0=C2=A0=C2=A0 images:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_arg: '-drive file=3D{s=
ystem},discard=3Dunmap,if=3Dnone,id=3Ddisk,format=3Draw -m 1G -serial mon:s=
tdio
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -nographic -netdev user,id=3D=
net,hostfwd=3Dtcp:127.0.0.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/t=
mp/qemu-swtpm.sock
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -tpmdev emulator,id=3Dtpm0,ch=
ardev=3Dchrtpm ${imageargs}'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url: downloads://cip-core-im=
age-security-cip-core-${distribution}-${architecture}.wic
>> diff --git a/tests/templates/blocks/header_mcom.yml b/tests/templates/bl=
ocks/header_mcom.yml
>> new file mode 100644
>> index 00000000..bf140cba
>> --- /dev/null
>> +++ b/tests/templates/blocks/header_mcom.yml
>> @@ -0,0 +1,29 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +job_name: mtda-mcom-${test_function}
>> +device_type: mcom-mtda
>> +timeouts:
>> +=C2=A0 job:
>> +=C2=A0=C2=A0=C2=A0 minutes: 180
>> +=C2=A0 action:
>> +=C2=A0=C2=A0=C2=A0 minutes: 95
>> +=C2=A0 connection:
>> +=C2=A0=C2=A0=C2=A0 minutes: 25
>> +priority: medium
>> +visibility: public
>> +context:
>> +=C2=A0 lava_test_results_dir: /home/lava/%s
>> +notify:
>> +=C2=A0 criteria:
>> +=C2=A0=C2=A0=C2=A0 status: finished
>> +=C2=A0 recipients:
>> +=C2=A0 - to:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 method: email
>> +=C2=A0=C2=A0=C2=A0=C2=A0 email: cip-testing-results@lists.cip-project.o=
rg
>> diff --git a/tests/templates/blocks/header_qemu.yml b/tests/templates/bl=
ocks/header_qemu.yml
>> new file mode 100644
>> index 00000000..cdd3c44c
>> --- /dev/null
>> +++ b/tests/templates/blocks/header_qemu.yml
>> @@ -0,0 +1,31 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# ${job_title}: "IEC layer testing" | "secure boot testing" | "software=
 update testing"
>> +device_type: qemu
>> +job_name: ${architecture} ${job_title}
>> +timeouts:
>> +=C2=A0 job:
>> +=C2=A0=C2=A0=C2=A0 minutes: 50
>> +=C2=A0 action:
>> +=C2=A0=C2=A0 minutes: 40
>> +=C2=A0 actions:
>> +=C2=A0=C2=A0=C2=A0 power-off:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seconds: 60
>> +priority: medium
>> +tags:
>> +- swtpm-jobs
>> +visibility: public
>> +notify:
>> +=C2=A0 criteria:
>> +=C2=A0=C2=A0=C2=A0 status: finished
>> +=C2=A0 recipients:
>> +=C2=A0 - to:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 method: email
>> +=C2=A0=C2=A0=C2=A0=C2=A0 email: cip-testing-results@lists.cip-project.o=
rg
>> diff --git a/tests/templates/blocks/monitor.yml b/tests/templates/blocks=
/monitor.yml
>> new file mode 100644
>> index 00000000..c089a0b1
>> --- /dev/null
>> +++ b/tests/templates/blocks/monitor.yml
>> @@ -0,0 +1,17 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 monitors:
>> +=C2=A0=C2=A0=C2=A0 - end: "${end_monitor}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: corrupted-${artifact}-image
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pattern: _unused_
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start: "${start_monitor}"
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 25
>> diff --git a/tests/templates/blocks/test_iec.yml b/tests/templates/block=
s/test_iec.yml
>> new file mode 100644
>> index 00000000..b935bf31
>> --- /dev/null
>> +++ b/tests/templates/blocks/test_iec.yml
>> @@ -0,0 +1,19 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# TEST_BLOCK
>> +- test:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: ${IEC_TEST_TIMEOUT_MINUTE=
S}
>> +=C2=A0=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - repository: https://gitlab.com/cip-project/c=
ip-testing/cip-security-tests.git
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: git
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 revision: 88134a939f06c456d4978db9=
c050f9afc74c5d3b
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: iec-security-tests/Singlenod=
e-TestDefinition.yaml
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: Security-Testcases
>> diff --git a/tests/templates/blocks/test_swupdate_apply.yml b/tests/temp=
lates/blocks/test_swupdate_apply.yml
>> new file mode 100644
>> index 00000000..45f692f3
>> --- /dev/null
>> +++ b/tests/templates/blocks/test_swupdate_apply.yml
>> @@ -0,0 +1,26 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# TEST_BLOCK 1
>> +# Fail the job if software update application failed
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 15
>> +=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0 - repository:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-Tes=
t Test Definition 1.0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-tes=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "Te=
st software update"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if=
 swupdate -l 5 -d "-u ${project_url}/${branch}/${architecture}/cip-core-ima=
ge-security-cip-core-${distribution}-${architecture}.swu"; then echo softwa=
re update is successful!!; else lava-test-raise "Fail job"; fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>> diff --git a/tests/templates/blocks/test_swupdate_check_ustate.yml b/tes=
ts/templates/blocks/test_swupdate_check_ustate.yml
>> new file mode 100644
>> index 00000000..9c9fbc6f
>> --- /dev/null
>> +++ b/tests/templates/blocks/test_swupdate_check_ustate.yml
>> @@ -0,0 +1,26 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# TEST BLOCK 2
>> +# Fail the job if ustate is not ${updatestate} after reboot
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 5
>> +=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0 - repository:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-Tes=
t Test Definition 1.0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-tes=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "ch=
eck boot loader environment variables"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if=
 [ $(bg_printenv | grep ustate | awk 'FNR =3D=3D 2{print $2}') =3D ${update=
state} ]; then bg_setenv -c; else lava-test-raise "Fail job"; fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>> diff --git a/tests/templates/blocks/test_swupdate_inline.yml b/tests/tem=
plates/blocks/test_swupdate_inline.yml
>> new file mode 100644
>> index 00000000..6c8f258f
>> --- /dev/null
>> +++ b/tests/templates/blocks/test_swupdate_inline.yml
>> @@ -0,0 +1,26 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# TEST_BLOCK
>> +# Fail the job if software update application error is not as expected
>> +# steps are inserted by code (see steps/)
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 25
>> +=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0 - repository:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-Tes=
t Test Definition 1.0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-tes=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "Te=
st software update by modifying the files"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps: []
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>> diff --git a/tests/templates/blocks/test_swupdate_mcom.yml b/tests/templ=
ates/blocks/test_swupdate_mcom.yml
>> new file mode 100644
>> index 00000000..b1f8556d
>> --- /dev/null
>> +++ b/tests/templates/blocks/test_swupdate_mcom.yml
>> @@ -0,0 +1,27 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# TEST BLOCK 1
>> +# Fail the job if software update application failed
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 15
>> +=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0 - repository:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-Tes=
t Test Definition 1.0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-tes=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "Te=
st software update"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - cu=
rl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/co=
mmon/cip-core-image-security-cip-core-${distribution}-x86-uefi.swu --output=
 test.swu
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if=
 swupdate -l 5 -i test.swu; then echo software update is successful!!; else=
 lava-test-raise "Fail job"; fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>> diff --git a/tests/templates/blocks/tpm_restart.yml b/tests/templates/bl=
ocks/tpm_restart.yml
>> new file mode 100644
>> index 00000000..7bc470ec
>> --- /dev/null
>> +++ b/tests/templates/blocks/tpm_restart.yml
>> @@ -0,0 +1,21 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# qemu-swtpm.sock will be gone after soft reboot.
>> +# So the swtpm socket need to be started again for proper reboot
>> +# To start the swtpm daemon, first the existing one should be killed
>> +- command:
>> +=C2=A0=C2=A0=C2=A0 name: manual_kill
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 1
>> +# Start the swtpm daemon
>> +- command:
>> +=C2=A0=C2=A0=C2=A0 name: start_tpm
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 1
>> diff --git a/tests/templates/jobs.yml b/tests/templates/jobs.yml
>> new file mode 100644
>> index 00000000..95911cd4
>> --- /dev/null
>> +++ b/tests/templates/jobs.yml
>> @@ -0,0 +1,193 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# QEMU LAVA job definitions, assembled by scripts/lava_jobs.py.
>> +#
>> +# Per test:
>> +#=C2=A0=C2=A0 output_name:=C2=A0 file name, format string over {test} a=
nd {target}
>> +#=C2=A0=C2=A0 blocks:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ordered fragm=
ent names (tests/templates/blocks, steps);
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapping fragments become top-level keys, list f=
ragments
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 are appended to `actions`
>> +#=C2=A0=C2=A0 steps:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optional=
; `fragment: <name>` or `inline: [..]`, inserted
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 into the first empty `steps: []` list
>> +#=C2=A0=C2=A0 values:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 substitution =
values (job_title, monitors, ...); updatestate
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 is the expected ustate in the check step (`) =
=3D N`), default 2
>> +#=C2=A0=C2=A0 per_arch:=C2=A0=C2=A0=C2=A0=C2=A0 {<target>: {values: {..=
.}, disk: vda, efi_name: ...}}
>> +#=C2=A0=C2=A0 targets:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optional list of s=
upported targets (others: nothing written);
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: the QEMU targets. M-COM (x86-uefi) mus=
t be listed.
>> +#=C2=A0=C2=A0 per_arch.<target>.blocks: replaces `blocks` for that targ=
et (M-COM)
>> +#=C2=A0=C2=A0 replace:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ordered [old, new]=
 string replacements over the parsed job
>> +#=C2=A0=C2=A0 per_arch.<target>.replace: same, for that target only (af=
ter `replace`)
>> +#=C2=A0=C2=A0 broken_swu:=C2=A0=C2=A0 deploy the '-broken.swu' update i=
mage
>> +#=C2=A0=C2=A0 swap_ovmf:=C2=A0=C2=A0=C2=A0 use OVMF keys of the other r=
elease (mismatch keys test)
>> +
>> +tests:
>> +=C2=A0 IEC:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: [header_qemu, action_tpm, deploy_tmpfs, boot=
_qemu, test_iec, context_qemu]
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: IEC layer testing
>> +=C2=A0=C2=A0=C2=A0 targets: &with_mcom [qemu-amd64, qemu-arm64, qemu-ar=
m, x86-uefi]
>> +=C2=A0=C2=A0=C2=A0 per_arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86-uefi:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocks: [header_mcom, deploy=
_mcom, boot_mcom, test_iec]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_function: I=
EC
>> +
>> +=C2=A0 secure-boot:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: [header_qemu, action_tpm, deploy_tmpfs, boot=
_qemu_secureboot, context_qemu]
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: secure boot testing
>> +=C2=A0=C2=A0=C2=A0 targets: *with_mcom
>> +=C2=A0=C2=A0=C2=A0 per_arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86-uefi:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocks: [header_mcom, deploy=
_mcom, boot_mcom_secureboot]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_function: s=
ecure-boot
>> +
>> +=C2=A0 swupdate:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: &swupdate_blocks
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [header_qemu, action_tpm, deploy_tmpfs, =
boot_qemu, test_swupdate_apply,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_restart, boot_after_update, te=
st_swupdate_check_ustate, context_qemu]
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: software update testing
>> +=C2=A0=C2=A0=C2=A0 targets: *with_mcom
>> +=C2=A0=C2=A0=C2=A0 per_arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86-uefi:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocks:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [header_mcom, de=
ploy_mcom_swu, deploy_mcom, boot_mcom,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_swupd=
ate_mcom, boot_mcom_after_update, test_swupdate_check_ustate]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_function: s=
wupdate
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 updatestate: 2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replace:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ["overlay-1.1.=
1.4", "overlay-2.1.1.4"]
>> +
>> +=C2=A0 kernel-panic:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: *swupdate_blocks
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: kernel-panic_rollback_testing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 updatestate: 3
>> +=C2=A0=C2=A0=C2=A0 replace:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ["kernel: C:BOOT1:linux.efi", "Kernel =
panic - not syncing: sysrq triggered crash"]
>> +=C2=A0=C2=A0=C2=A0 broken_swu: true
>> +
>> +=C2=A0 initramfs-crash:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: *swupdate_blocks
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: initramfs-crash_rollback_test=
ing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 updatestate: 3
>> +=C2=A0=C2=A0=C2=A0 replace:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ["kernel: C:BOOT1:linux.efi", "Can't o=
pen verity rootfs - continuing will lead to a broken trust chain!"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ["echo software update is successful!!=
", "dd if=3D/dev/urandom of=3D/dev/sda5 bs=3D512 count=3D1"]
>> +
>> +=C2=A0 swupdate-reboot-without-confirm:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_reboot_without_confirm_{target}=
.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [header_qemu, action_tpm, deploy_tmpfs, =
boot_qemu, test_swupdate_apply,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_restart, boot_after_update, te=
st_swupdate_check_ustate,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reboot_without_confirm, context_qe=
mu]
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: software update testing
>> +=C2=A0=C2=A0=C2=A0 replace:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ["bg_setenv -c", "echo No update confi=
rm"]
>> +
>> +=C2=A0 secure-boot-unsigned-kernel:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_unsigned_kernel_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: &secureboot_negative_blocks
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [header_qemu, action_tpm, deploy_downloa=
ds_postprocess,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy_tmpfs_downloaded, boot_qemu=
_noprompt, monitor, context_qemu]
>> +=C2=A0=C2=A0=C2=A0 steps: {fragment: unsigned_kernel}
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: secure boot testing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 artifact: linux
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_monitor: Cannot load specified ker=
nel image
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_monitor: Access Denied
>> +=C2=A0=C2=A0=C2=A0 per_arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-arm64: &unsigned_kernel_arm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk: vda
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_monitor: I=
mage not authenticated
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_monitor: App=
lication failed
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-arm: *unsigned_kernel_arm
>> +
>> +=C2=A0 secure-boot-unsigned-bootloader:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_unsigned_bootloader_{target}.ym=
l"
>> +=C2=A0=C2=A0=C2=A0 blocks: *secureboot_negative_blocks
>> +=C2=A0=C2=A0=C2=A0 steps: {fragment: unsigned_bootloader}
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: secure boot testing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 artifact: bootloader
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_monitor: Access Denied
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_monitor: "BdsDxe: failed to load Boo=
t"
>> +=C2=A0=C2=A0=C2=A0 per_arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-arm64:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk: vda
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_name: bootaa64.efi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 values: &unsigned_bootloader=
_arm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_monitor: I=
mage not authenticated
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_monitor: EFI=
 Boot failed!
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-arm:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk: vda
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_name: bootarm.efi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 values: *unsigned_bootloader=
_arm
>> +
>> +=C2=A0 secure-boot-corrupt-rootfs:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_corrupt_rootfs_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: *secureboot_negative_blocks
>> +=C2=A0=C2=A0=C2=A0 steps: {fragment: corrupt_rootfs}
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: secure boot testing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 artifact: rootfs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_monitor: "EFI stub: UEFI Secure Bo=
ot is enabled."
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_monitor: "reboot: Restarting system =
with command 'dm-verity device corrupted'"
>> +=C2=A0=C2=A0=C2=A0 per_arch:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-arm64:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_name: bootaa64.efi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-arm:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_name: bootarm.efi
>> +
>> +=C2=A0 secure-boot-mismatch-keys:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_mismatch_keys_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 targets: [qemu-amd64]
>> +=C2=A0=C2=A0=C2=A0 blocks: *secureboot_negative_blocks
>> +=C2=A0=C2=A0=C2=A0 steps: {inline: ["echo 'no postprocess steps'"]}
>> +=C2=A0=C2=A0=C2=A0 swap_ovmf: true
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: secure boot testing
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 artifact: keys
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_monitor: Access Denied
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_monitor: "BdsDxe: failed to load Boo=
t"
>> +
>> +=C2=A0 swupdate-corrupt-swu:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_corrupt_swu_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: &swupdate_negative_blocks
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [header_qemu, action_tpm, deploy_swu, de=
ploy_tmpfs, boot_qemu,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_swupdate_inline, context_qemu=
]
>> +=C2=A0=C2=A0=C2=A0 steps: {fragment: corrupt_swu}
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: software update testing
>> +
>> +=C2=A0 swupdate-corrupt-swu-artifact:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_corrupt_swu_artifact_{target}.y=
ml"
>> +=C2=A0=C2=A0=C2=A0 blocks: *swupdate_negative_blocks
>> +=C2=A0=C2=A0=C2=A0 steps: {fragment: corrupt_swu_artifact}
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: software update testing
>> +
>> +=C2=A0 swupdate-apply-same-image-swu:
>> +=C2=A0=C2=A0=C2=A0 output_name: "{test}_same_uuid_{target}.yml"
>> +=C2=A0=C2=A0=C2=A0 blocks: *swupdate_negative_blocks
>> +=C2=A0=C2=A0=C2=A0 steps: {fragment: same_uuid}
>> +=C2=A0=C2=A0=C2=A0 values:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_title: software update testing
>> diff --git a/tests/templates/steps/corrupt_rootfs.yml b/tests/templates/=
steps/corrupt_rootfs.yml
>> new file mode 100644
>> index 00000000..e48f29d6
>> --- /dev/null
>> +++ b/tests/templates/steps/corrupt_rootfs.yml
>> @@ -0,0 +1,16 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- "apt-get update"
>> +- "DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y fdisk"
>> +- "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-image-securi=
ty-cip-core-${distribution}-${architecture}.wic | awk -v name=3Dsystema '$0=
 ~ name {print $2}')"
>> +- "rootfs_start=3D$((${rootfs_start_sector} * 512))"
>> +# The value 96 is squashfs superblock header size, so skip header and c=
orrupt the data after that.
>> +- "offset=3D$((${rootfs_start} + 96))"
>> +- "dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-${distributi=
on}-${architecture}.wic bs=3D1 seek=3D${offset} count=3D8 conv=3Dnotrunc"
>> diff --git a/tests/templates/steps/corrupt_swu.yml b/tests/templates/ste=
ps/corrupt_swu.yml
>> new file mode 100644
>> index 00000000..7bcc9eef
>> --- /dev/null
>> +++ b/tests/templates/steps/corrupt_swu.yml
>> @@ -0,0 +1,15 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/down=
loads/common/cip-core-image-security-cip-core-${distribution}-${architectur=
e}.swu --output /root/cip-core-image-security-cip-core-${distribution}-${ar=
chitecture}.swu
>> +- mkdir -p swu
>> +- dd if=3D/dev/zero of=3D/root/cip-core-image-security-cip-core-${distr=
ibution}-${architecture}.swu bs=3D1M count=3D5
>> +- swupdate -l 5 -i /root/cip-core-image-security-cip-core-${distributio=
n}-${architecture}.swu > /root/swupdate.txt
>> +- cat /root/swupdate.txt
>> +- if grep -q "CPIO Header corrupted, cannot be parsed" /root/swupdate.t=
xt; then echo ".swu file corrupt test verification successful!!!"; else lav=
a-test-raise "Fail job"; fi
>> diff --git a/tests/templates/steps/corrupt_swu_artifact.yml b/tests/temp=
lates/steps/corrupt_swu_artifact.yml
>> new file mode 100644
>> index 00000000..2c2ce0d8
>> --- /dev/null
>> +++ b/tests/templates/steps/corrupt_swu_artifact.yml
>> @@ -0,0 +1,18 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/down=
loads/common/cip-core-image-security-cip-core-${distribution}-${architectur=
e}.swu --output /root/cip-core-image-security-cip-core-${distribution}-${ar=
chitecture}.swu
>> +- mkdir -p swu
>> +- cpio -ivd --directory=3D/root/swu < /root/cip-core-image-security-cip=
-core-${distribution}-${architecture}.swu
>> +- dd if=3D/dev/zero of=3D/root/swu/cip-core-image-security-cip-core-${d=
istribution}-${architecture}.delta_update bs=3D1 count=3D256
>> +- cd /root/swu
>> +- for file in sw-description sw-description.sig cip-core-image-security=
-cip-core-${distribution}-${architecture}.delta_update linux.efi; do echo "=
${file}"; done | cpio -ovL --reproducible -H crc > cip-core-image-security-=
cip-core-${distribution}-${architecture}.swu
>> +- swupdate -l 5 -i cip-core-image-security-cip-core-${distribution}-${a=
rchitecture}.swu > /root/swupdate.txt
>> +- cat /root/swupdate.txt
>> +- if grep -q "Image invalid or corrupted" /root/swupdate.txt; then echo=
 "kernel file corrupt test verification successful!!"; else lava-test-raise=
 "Fail job"; fi
>> diff --git a/tests/templates/steps/reboot_without_confirm.yml b/tests/te=
mplates/steps/reboot_without_confirm.yml
>> new file mode 100644
>> index 00000000..dcad0b95
>> --- /dev/null
>> +++ b/tests/templates/steps/reboot_without_confirm.yml
>> @@ -0,0 +1,54 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +# qemu-swtpm.sock will be gone after soft reboot.
>> +# So the swtpm socket need to be started again for proper reboot
>> +# To start the swtpm daemon, first the existing one should be killed
>> +- command:
>> +=C2=A0=C2=A0=C2=A0 name: manual_kill
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 1
>> +# Start the swtpm daemon
>> +- command:
>> +=C2=A0=C2=A0=C2=A0 name: start_tpm
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 1
>> +
>> +- boot:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 5
>> +=C2=A0=C2=A0=C2=A0 method: qemu
>> +=C2=A0=C2=A0=C2=A0 media: tmpfs
>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>> +=C2=A0=C2=A0=C2=A0 auto_login:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_commands:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if mountpoint /home; then =
mount -o remount,exec /home; else mount -o remount,exec /var; fi
>> +=C2=A0=C2=A0=C2=A0 parameters:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel-start-message: "kernel: C:B=
OOT0:linux.efi"
>> +
>> +# Fail the job if ustate is not 3 (failed) after reboot
>> +- test:
>> +=C2=A0=C2=A0=C2=A0 timeout:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 5
>> +=C2=A0=C2=A0=C2=A0 definitions:
>> +=C2=A0=C2=A0=C2=A0 - repository:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-Tes=
t Test Definition 1.0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-tes=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "ch=
eck boot loader environment variables"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if=
 [ $(bg_printenv | grep ustate | awk 'FNR =3D=3D 2{print $2}') =3D 3 ]; the=
n echo ustate status failed; else lava-test-raise "Fail job"; fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-3
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>> diff --git a/tests/templates/steps/same_uuid.yml b/tests/templates/steps=
/same_uuid.yml
>> new file mode 100644
>> index 00000000..d9f1e4a8
>> --- /dev/null
>> +++ b/tests/templates/steps/same_uuid.yml
>> @@ -0,0 +1,18 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/down=
loads/common/cip-core-image-security-cip-core-${distribution}-${architectur=
e}.swu --output /root/cip-core-image-security-cip-core-${distribution}-${ar=
chitecture}.swu
>> +- mkdir -p swu
>> +- cpio -ivd --directory=3D/root/swu < /root/cip-core-image-security-cip=
-core-${distribution}-${architecture}.swu
>> +- current_uuid=3D$( cat /etc/os-release | grep IMAGE_UUID=3D | cut -d'"=
' -f 2)
>> +- swu_uuid=3D$(cat /root/swu/sw-description | grep IMAGE_UUID | cut -d'=
=3D' -f3 | cut -c 1-36)
>> +- sed -i s/$current_uuid/$swu_uuid/g /etc/os-release
>> +- swupdate -l 5 -i /root/cip-core-image-security-cip-core-${distributio=
n}-${architecture}.swu > /root/swupdate.txt
>> +- cat /root/swupdate.txt
>> +- if grep -q "'configfilecheck()' failed" /root/swupdate.txt; then echo=
 "test verification successful!!!"; else lava-test-raise "Fail job"; fi
>> diff --git a/tests/templates/steps/unsigned_bootloader.yml b/tests/templ=
ates/steps/unsigned_bootloader.yml
>> new file mode 100644
>> index 00000000..13592a77
>> --- /dev/null
>> +++ b/tests/templates/steps/unsigned_bootloader.yml
>> @@ -0,0 +1,16 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- "apt-get update"
>> +- "DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y guestfish sbsign=
tool"
>> +- "guestfish add cip-core-image-security-cip-core-${distribution}-${arc=
hitecture}.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi .=
"
>> +- "sbverify --list bootx64.efi"
>> +- "sbattach --remove bootx64.efi"
>> +- "sbverify --list bootx64.efi"
>> +- "guestfish add cip-core-image-security-cip-core-${distribution}-${arc=
hitecture}.wic : run : mount /dev/sda1 / : copy-in bootx64.efi /EFI/BOOT/"
>> diff --git a/tests/templates/steps/unsigned_kernel.yml b/tests/templates=
/steps/unsigned_kernel.yml
>> new file mode 100644
>> index 00000000..d9bd5845
>> --- /dev/null
>> +++ b/tests/templates/steps/unsigned_kernel.yml
>> @@ -0,0 +1,16 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +- "apt-get update"
>> +- "DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y guestfish sbsign=
tool"
>> +- "guestfish add cip-core-image-security-cip-core-${distribution}-${arc=
hitecture}.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>> +- "sbverify --list linux.efi"
>> +- "sbattach --remove linux.efi"
>> +- "sbverify --list linux.efi"
>> +- "guestfish add cip-core-image-security-cip-core-${distribution}-${arc=
hitecture}.wic : run : mount /dev/sda2 / : copy-in linux.efi /"
>> diff --git a/tests/test_lava_branch_names.py b/tests/test_lava_branch_na=
mes.py
>> new file mode 100644
>> index 00000000..99a21b0c
>> --- /dev/null
>> +++ b/tests/test_lava_branch_names.py
>> @@ -0,0 +1,52 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Tests that branch and distribution names are kept verbatim."""
>> +
>> +import pathlib
>> +import sys
>> +import unittest
>> +
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
>> +
>> +from lava_test_helpers import all_strings, lava_jobs=C2=A0 # noqa: E402
>> +
>> +
>> +BRANCHES =3D ("fix-sda-x", "a.swu-b", "x-bootx64.efi-y", "trixie-ovmf")
>> +# (test, target) pairs that run the sda, .swu, bootx64.efi and OVMF rew=
rites.
>> +REWRITING_JOBS =3D (
>> +=C2=A0=C2=A0=C2=A0 ("kernel-panic", "qemu-amd64"),
>> +=C2=A0=C2=A0=C2=A0 ("secure-boot-unsigned-bootloader", "qemu-arm64"),
>> +=C2=A0=C2=A0=C2=A0 ("secure-boot-unsigned-kernel", "qemu-arm"),
>> +=C2=A0=C2=A0=C2=A0 ("secure-boot-mismatch-keys", "qemu-amd64"),
>> +)
>> +
>> +
>> +class BranchVerbatimTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_urls_keep_branch_verbatim(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for branch in BRANCHES:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
test, target in REWRITING_JOBS:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 with self.subTest(branch=3Dbranch, test=3Dtest, targe=
t=3Dtarget):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variabl=
es(target, "trixie", branch, "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(t=
est, target, v)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 urls =3D [s for s in all_stri=
ngs(job)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if s.startswith(lava_jobs.PROJECT_URL)]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(urls)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for url in urls:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.=
assertIn(f"/{branch}/", url)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_distribution_kept_verbatim(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variab=
les("qemu-arm64", "sda.swu", "br", "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(=
"secure-boot-unsigned-kernel", "qemu-arm64", v)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strin=
gs(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("cip-core-sda.=
swu-qemu-arm64.wic", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("/dev/vda2", t=
ext)
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 unittest.main()
>> diff --git a/tests/test_lava_cli.py b/tests/test_lava_cli.py
>> new file mode 100644
>> index 00000000..7edcca5a
>> --- /dev/null
>> +++ b/tests/test_lava_cli.py
>> @@ -0,0 +1,87 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Tests for the lava_jobs command line and its error handling."""
>> +
>> +import pathlib
>> +import sys
>> +import tempfile
>> +import unittest
>> +from unittest import mock
>> +
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
>> +
>> +from lava_test_helpers import build, lava_jobs=C2=A0 # noqa: E402
>> +
>> +
>> +class CommandLineTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_mismatch_keys_arm64_writes_nothing(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "secure-boot-mismatch-keys",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--target", "qemu-arm64", =
"--release", "trixie",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--branch", "br", "--iec-t=
imeout", "30", "--out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(list(pathlib.Path(d).iterdir()), [])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_unknown_test_exits_nonzero(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(Value=
Error):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buil=
d("no-such-test", "qemu-amd64")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "no-such-test", "--target", "qemu-amd64",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "30", "--=
out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertNotEqual(rc, 0)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_malformed_target_exits_nonzero(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for target in ("qemu", "foo"=
):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(target=3Dtarget), tempfile.TemporaryDirectory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rc =3D lava_jobs.main(["--test", "swupdate", "--targe=
t", target,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-=
-release", "trixie", "--branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-=
-iec-timeout", "30", "--out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertNotEqual(rc, 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(list(pathlib.Path(d).iterdir()), [])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_main_writes_output_filename(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "swupdate", "--target", "qemu-arm",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "30", "--=
out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out =
=3D pathlib.Path(d) / "swupdate_qemu-arm.yml"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(lava_jobs.load_yaml(out)["device_type"], "qemu")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_main_creates_missing_out_dir(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out =
=3D pathlib.Path(d) / "a" / "b"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "swupdate", "--target", "qemu-arm",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "30", "--=
out", str(out)])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertTrue((out / "swupdate_qemu-arm.yml").exists())
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_main_reports_missing_variable(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d, \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mock.patch.object(lava_jobs, "build_job", side_effect=
=3DKeyError("x")):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "swupdate", "--target", "qemu-arm",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "30", "--=
out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(list(pathlib.Path(d).iterdir()), [])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_iec_with_empty_timeout_fails_early(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "IEC", "--target", "qemu-arm",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "", "--ou=
t", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(list(pathlib.Path(d).iterdir()), [])
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 unittest.main()
>> diff --git a/tests/test_lava_core.py b/tests/test_lava_core.py
>> new file mode 100644
>> index 00000000..bb21c456
>> --- /dev/null
>> +++ b/tests/test_lava_core.py
>> @@ -0,0 +1,61 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Tests for variable building, firmware and job writing."""
>> +
>> +import pathlib
>> +import sys
>> +import tempfile
>> +import unittest
>> +
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
>> +
>> +from lava_test_helpers import lava_jobs=C2=A0 # noqa: E402
>> +
>> +
>> +class CoreTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_build_variables_context_arch(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variab=
les("qemu-arm64", "trixie", "next", "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(v["context_=
architecture"], "arm64")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_build_variables_imageargs_amd64_uses_releas=
e(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variab=
les("qemu-amd64", "trixie", "next", "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("trixie-ovmf",=
 v["imageargs"])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_build_variables_imageargs_empty_for_unknown=
_target(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variab=
les("x86-uefi", "trixie", "next", "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(v["imagearg=
s"], "")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(v["context_=
architecture"], "uefi")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_add_firmware_adds_images_firmware(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variab=
les("qemu-arm64", "trixie", "next", "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy =3D {"images": {}}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lava_jobs.add_firmware(deplo=
y, v)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw =3D deploy["images"]["fir=
mware"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(fw["image_a=
rg"], "-bios {firmware}")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(fw["url"].en=
dswith("/next/qemu-arm64/firmware.bin"))
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_load_fragment_corrupt_rootfs_keeps_shell_va=
rs(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D lava_jobs.build_variab=
les("qemu-arm64", "trixie", "next", "30")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps =3D lava_jobs.load_fra=
gment("corrupt_rootfs", v)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(str(s) fo=
r s in steps)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("${rootfs_star=
t}", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("trixie-qemu-a=
rm64", text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_write_job_roundtrip(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D {"z": 1, "a": "x" * =
500}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path=
 =3D pathlib.Path(d) / "job.yml"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lava=
_jobs.write_job(job, path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(lava_jobs.load_yaml(path), job)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(len(path.read_text().splitlines()), 2)
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 unittest.main()
>> diff --git a/tests/test_lava_fragments.py b/tests/test_lava_fragments.py
>> new file mode 100644
>> index 00000000..f6f83644
>> --- /dev/null
>> +++ b/tests/test_lava_fragments.py
>> @@ -0,0 +1,73 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Tests for the YAML fragments and placeholder substitution."""
>> +
>> +import pathlib
>> +import sys
>> +import unittest
>> +
>> +import yaml
>> +
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
>> +
>> +from lava_test_helpers import TEMPLATES, lava_jobs=C2=A0 # noqa: E402
>> +
>> +
>> +class FragmentTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_all_fragments_parse(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 files =3D []
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for sub in ("blocks", "steps=
"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
s +=3D sorted((TEMPLATES / sub).glob("*.yml"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(files, "no f=
ragments found")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for f in files:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(fragment=3Df.name):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertIsNotNone(yaml.safe_load(f.read_text()))
>> +
>> +
>> +JOBS_YML =3D TEMPLATES / "jobs.yml"
>> +# ${name} forms in fragments that are shell variables, not placeholders=
.
>> +SHELL_VARIABLES =3D ("file", "offset", "rootfs_start", "rootfs_start_se=
ctor")
>> +
>> +
>> +class PlaceholderTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_substitute_replaces_known(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out =3D lava_jobs.substitute=
("a ${branch} b", {"branch": "next"})
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(out, "a nex=
t b")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_substitute_missing_variable_raises(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(KeyEr=
ror):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lava=
_jobs.substitute("a ${branch}", {})
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_substitute_keeps_shell_variables(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "curl $LAVA_DISPATC=
HER_IP/${offset}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(lava_jobs.s=
ubstitute(text, {}), text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_substitute_leaves_unknown_shell_variables(s=
elf):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "x=3D$(( ${rootfs_s=
tart} + 1 )) $LAVA_JOB_ID ${file}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out =3D lava_jobs.substitute=
(text, {"branch": "b"})
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(out, text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_substitute_leaves_dollar_dollar_and_bare_na=
mes(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "$$x $branch ${arte=
fact}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(lava_jobs.s=
ubstitute(text, {"branch": "b"}), text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_fragments_use_only_known_or_shell_variables=
(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 files =3D [JOBS_YML]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for sub in ("blocks", "steps=
"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
s +=3D sorted((TEMPLATES / sub).glob("*.yml"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allowed =3D set(lava_jobs.KN=
OWN_VARIABLES) | set(SHELL_VARIABLES)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for f in files:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(fragment=3Df.name):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 names =3D set(lava_jobs.PLACEHOLDER.findall(f.read_te=
xt()))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(names - allowed, set())
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 unittest.main()
>> diff --git a/tests/test_lava_mcom_jobs.py b/tests/test_lava_mcom_jobs.py
>> new file mode 100644
>> index 00000000..1cae7c20
>> --- /dev/null
>> +++ b/tests/test_lava_mcom_jobs.py
>> @@ -0,0 +1,107 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Tests for the MCOM jobs and the IEC test block."""
>> +
>> +import pathlib
>> +import sys
>> +import tempfile
>> +import unittest
>> +
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
>> +
>> +from lava_test_helpers import all_strings, lava_jobs=C2=A0 # noqa: E402
>> +
>> +
>> +QEMU_TARGETS =3D ("qemu-amd64", "qemu-arm64", "qemu-arm")
>> +
>> +
>> +def mcom_variables(iec_timeout=3D"30"):
>> +=C2=A0=C2=A0=C2=A0 return lava_jobs.build_variables("x86-uefi", "trixie=
", "br", iec_timeout)
>> +
>> +
>> +def tests_of(job):
>> +=C2=A0=C2=A0=C2=A0 return [a["test"] for a in job["actions"] if "test" =
in a]
>> +
>> +
>> +class McomJobTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_iec_has_timeout(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(=
"IEC", "x86-uefi", mcom_variables("45"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(tests_of(jo=
b)[0]["timeout"]["minutes"], 45)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_job_name_contains_test_function(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for test in ("IEC", "secure-=
boot", "swupdate"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(test=3Dtest):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(test, "x86-uefi", mcom_va=
riables())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(job["job_name"], f"mtda-mcom-{test}"=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(job["device_type"], "mcom-mtda")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_swupdate_updatestate_2(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(=
"swupdate", "x86-uefi", mcom_variables())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strin=
gs(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn(") =3D 2 ]", t=
ext)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_swupdate_deploys_swu_first(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(=
"swupdate", "x86-uefi", mcom_variables())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploys =3D [a["deploy"] for=
 a in job["actions"] if "deploy" in a]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual([d["to"] fo=
r d in deploys], ["downloads", "flasher"])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(deploys[0]["=
images"]["image"]["url"].endswith(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/br=
/x86-uefi/cip-core-image-security-cip-core-trixie-x86-uefi.swu"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("deploy", job[=
"actions"][0])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_overlay_renamed_for_swupdate_only(self=
):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for test, overlay in (("swup=
date", "overlay-2.1.1.4"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("IEC", "overlay-1.1.1.4"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("secure-boot", "overlay-1.1.1.4")):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(test=3Dtest):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(test, "x86-uefi", mcom_va=
riables())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strings(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertIn(f"--output {overlay}.tar.gz", text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_secure_boot_checks_kernel_start_messag=
e(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(=
"secure-boot", "x86-uefi", mcom_variables())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot =3D job["actions"][-1][=
"boot"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(boot["param=
eters"]["kernel-start-message"],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "EFI stub: UEFI Secure Boot is enabled.")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_has_no_firmware(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for test in ("IEC", "secure-=
boot", "swupdate"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(test=3Dtest):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job(test, "x86-uefi", mcom_va=
riables())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("firmware.bin", "\n".join(all_string=
s(job)))
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mcom_unsupported_test_writes_nothing(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "kernel-panic", "--target", "x86-uefi",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "30", "--=
out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(list(pathlib.Path(d).iterdir()), [])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_main_writes_mcom_job(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with tempfile.TemporaryDirec=
tory() as d:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D lava_jobs.main(["--test", "IEC", "--target", "x86-uefi",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--release", "trixie", "--=
branch", "br",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--iec-timeout", "30", "--=
out", d])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(rc, 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out =
=3D pathlib.Path(d) / "IEC_x86-uefi.yml"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertEqual(lava_jobs.load_yaml(out)["device_type"], "mcom-mtda")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_qemu_iec_has_test_block(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for target in QEMU_TARGETS:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(target=3Dtarget):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 variables =3D lava_jobs.build_variables(target, "trix=
ie", "br", "45")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 job =3D lava_jobs.build_job("IEC", target, variables)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tests =3D tests_of(job)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(tests[-1]["timeout"]["minutes"], 45)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(tests[-1]["definitions"][0]["name"],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Security-Testcases")
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 unittest.main()
>> diff --git a/tests/test_lava_qemu_jobs.py b/tests/test_lava_qemu_jobs.py
>> new file mode 100644
>> index 00000000..b5092d25
>> --- /dev/null
>> +++ b/tests/test_lava_qemu_jobs.py
>> @@ -0,0 +1,112 @@
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +"""Tests for the QEMU LAVA jobs and the generator command line."""
>> +
>> +import pathlib
>> +import sys
>> +import re
>> +import unittest
>> +
>> +import yaml
>> +
>> +sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
>> +
>> +from lava_test_helpers import all_strings, build, lava_jobs=C2=A0 # noq=
a: E402
>> +
>> +
>> +def monitor(job):
>> +=C2=A0=C2=A0=C2=A0 tests =3D [a["test"] for a in job["actions"] if "tes=
t" in a]
>> +=C2=A0=C2=A0=C2=A0 return tests[-1]["monitors"][0]
>> +
>> +
>> +def postprocess_steps(job):
>> +=C2=A0=C2=A0=C2=A0 return job["actions"][1]["deploy"]["postprocess"]["d=
ocker"]["steps"]
>> +
>> +
>> +class QemuJobTests(unittest.TestCase):
>> +=C2=A0=C2=A0=C2=A0 def test_unsigned_kernel_amd64_monitors(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mon =3D monitor(build("secur=
e-boot-unsigned-kernel", "qemu-amd64"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(mon["end"],=
 "Access Denied")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(mon["start"=
], "Cannot load specified kernel image")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(mon["name"]=
, "corrupted-linux-image")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_unsigned_kernel_arm64_uses_vda_and_firmware=
(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D build("secure-boot-u=
nsigned-kernel", "qemu-arm64")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(postproce=
ss_steps(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("/dev/vda2", t=
ext)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("sda", text=
)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploys =3D [a["deploy"] for=
 a in job["actions"] if "deploy" in a]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("firmware", de=
ploys[-1]["images"])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(monitor(job=
)["end"], "Application failed")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_unsigned_bootloader_arm_uses_bootarm_efi(se=
lf):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D build("secure-boot-u=
nsigned-bootloader", "qemu-arm")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(postproce=
ss_steps(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("bootarm.efi",=
 text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("bootx64.ef=
i", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("/dev/vda1", t=
ext)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_kernel_panic_updatestate_3_and_broken_swu(s=
elf):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D build("kernel-panic"=
, "qemu-amd64")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strin=
gs(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn(") =3D 3 ]", t=
ext)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn(") =3D 2 ]"=
, text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("-broken.swu",=
 text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("Kernel panic =
- not syncing: sysrq triggered crash", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(job["job_na=
me"], "qemu-amd64 kernel-panic_rollback_testing")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(lava_jobs.o=
utput_filename("kernel-panic", "qemu-amd64"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "kernel-panic.yml")
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_initramfs_crash_replaces_success_with_dd(se=
lf):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strin=
gs(build("initramfs-crash", "qemu-amd64")))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("dd if=3D/dev/=
urandom of=3D/dev/sda5 bs=3D512 count=3D1", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("echo softw=
are update is successful!!", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("-broken.sw=
u", text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mismatch_keys_swaps_ovmf_distro(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for release, keys in (("trix=
ie", "bookworm"), ("bookworm", "trixie")):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(release=3Drelease):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 job =3D build("secure-boot-mismatch-keys", "qemu-amd6=
4", release)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strings(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertIn(f"{keys}-ovmf", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn(f"{release}-ovmf", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(postprocess_steps(job), ["echo 'no p=
ostprocess steps'"])
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_reboot_without_confirm_replaces_bg_setenv(s=
elf):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D build("swupdate-rebo=
ot-without-confirm", "qemu-arm")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D "\n".join(all_strin=
gs(job))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("bg_setenv =
-c", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("echo No updat=
e confirm", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn("kernel: C:BOO=
T0:linux.efi", text)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_no_unreplaced_placeholders_for_all_tests(se=
lf):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for test in lava_jobs.load_j=
obs():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
target in lava_jobs.TARGETS:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 with self.subTest(test=3Dtest, target=3Dtarget):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not lava_jobs.is_supported=
(test, target):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job =3D build(test, target)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D yaml.safe_dump(job)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(lava_jobs.fi=
nd_unreplaced(text), [])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIsNone(re.search(r=
"#[A-Za-z_-]+#", text))
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_check_ustate_step_uses_updatestate(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text =3D lava_jobs.fragment_=
path("test_swupdate_check_ustate").read_text()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertIn(") =3D ${updat=
estate} ]", text)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse(hasattr(lav=
a_jobs, "set_update_state"))
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_updatestate_only_set_in_values(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for name, spec in lava_jobs.=
load_jobs().items():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with=
 self.subTest(test=3Dname):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.assertNotIn("updatestate", spec)
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +=C2=A0=C2=A0=C2=A0 unittest.main()
>> --=20
>> 2.47.3

