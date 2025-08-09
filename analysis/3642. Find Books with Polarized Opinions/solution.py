from decimal import Decimal, ROUND_HALF_UP
import pandas as pd


def find_polarized_books(books: pd.DataFrame, reading_sessions: pd.DataFrame) -> pd.DataFrame:
    
    initial_analysis =  (
        reading_sessions
        .groupby('book_id')
        .agg(
            sessions_count=("session_id", 'nunique'),
            star_two=('session_rating', lambda x: (x <= 2).sum()),
            star_four=('session_rating', lambda x: (x >=4).sum()),
            lowest_rating=("session_rating", 'min'), 
            highest_rating=("session_rating", 'max')
        )
        .reset_index()
    )

    final_analysis = initial_analysis[ 
        (initial_analysis["sessions_count"] >= 5) &
        (initial_analysis["star_four"] >= 1) &
        (initial_analysis["star_two"] >= 1)
    ]

    final_analysis = final_analysis.copy()

    final_analysis["rating_spread"] = final_analysis["highest_rating"] - final_analysis["lowest_rating"]

    final_analysis["polarization_score"] = ((final_analysis["star_two"] + final_analysis["star_four"]) / final_analysis["sessions_count"]).apply(lambda x: float(Decimal(str(x)).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)))

    final_analysis = final_analysis[final_analysis["polarization_score"] >= 0.6][['book_id', 'rating_spread', 'polarization_score']]

    df = pd.merge(books, final_analysis, on="book_id", how="inner")

    df.sort_values(by=["polarization_score", 'title'], ascending=[False, False], inplace=True)

    return df

if __name__ == '__main__':
    """ Example 1: """
    data = [[1, 'The Great Gatsby', 'F. Scott', 'Fiction', 180], [2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 281], [3, '1984', 'George Orwell', 'Dystopian', 328], [4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 432], [5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 277]]
    books = pd.DataFrame(data, columns=["book_id","title","author","genre","pages",])

    data = [[1, 1, 'Alice', 50, 5], [2, 1, 'Bob', 60, 1], [3, 1, 'Carol', 40, 4], [4, 1, 'David', 30, 2], [5, 1, 'Emma', 45, 5], [6, 2, 'Frank', 80, 4], [7, 2, 'Grace', 70, 4], [8, 2, 'Henry', 90, 5], [9, 2, 'Ivy', 60, 4], [10, 2, 'Jack', 75, 4], [11, 3, 'Kate', 100, 2], [12, 3, 'Liam', 120, 1], [13, 3, 'Mia', 80, 2], [14, 3, 'Noah', 90, 1], [15, 3, 'Olivia', 110, 4], [16, 3, 'Paul', 95, 5], [17, 4, 'Quinn', 150, 3], [18, 4, 'Ruby', 140, 3], [19, 5, 'Sam', 80, 1], [20, 5, 'Tara', 70, 2]]
    reading_sessions = pd.DataFrame(data, columns=["session_id","book_id","reader_name","pages_read","session_rating"  ])

    result_df = find_polarized_books(books=books, reading_sessions=reading_sessions)
    print(result_df)