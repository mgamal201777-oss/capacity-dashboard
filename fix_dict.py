import re

with open(r'c:\Users\Mohamed Gamal\Desktop\capacity-dashboard\index.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Fix corrupted Korean chars in dict values
content = re.sub(r"'Good Partners Target': '[^']*'", "'Good Partners Target': '优质合作商目标'", content)
content = re.sub(r"'Average Partners Target': '[^']*'", "'Average Partners Target': '中等合作商目标'", content)
content = re.sub(r"'Bad Partners Target': '待改善[^']*'", "'Bad Partners Target': '待改善合作商目标'", content)
content = re.sub(r"'Face Recognition \(FR\) All Partners Summary - Target Changes Across Ranges': '[^']*'",
                 "'Face Recognition (FR) All Partners Summary - Target Changes Across Ranges': 'FR - 全部合作商汇总 - 各范围目标变化'",
                 content)

# Remove bad entries with Korean keys/mixed keys
content = re.sub(r"\n        'Face Recognition \(FR\) Range Impact - 目标 Changes \(Jan vs Feb\)': '[^']*',", '', content)
content = re.sub(r"\n        '총계 cities:': '[^']*',", '', content)
content = re.sub(r"\n        'New: ': '[^']*',", '', content)
content = re.sub(r"\n        'All Partners of total': '[^']*',", '', content)

with open(r'c:\Users\Mohamed Gamal\Desktop\capacity-dashboard\index.html', 'w', encoding='utf-8') as f:
    f.write(content)

print('Done - fixed dict entries')
