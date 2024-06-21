export function getLastMonthString(): string {
    const date = new Date();
    date.setMonth(date.getMonth() - 1);
    return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}`;
  }
  
  export function getCurrentMonthString(): string {
    const date = new Date();
    return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}`;
  }