<?php
session_start();
?>
<header>
    <nav>
        <ul>
            <li><a href="index.php">Accueil</a></li>
            <li><a href="gallery.php">Galerie</a></li>
            <?php if (isset($_SESSION['user_id'])): ?>
                <li><a href="edit.php">Éditer une photo</a></li>
                <li><a href="logout.php">Déconnexion</a></li>
            <?php else: ?>
                <li><a href="login.php">Connexion</a></li>
                <li><a href="register.php">Inscription</a></li>
            <?php endif; ?>
        </ul>
    </nav>
</header>